import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/validators.dart';

GlobalKey<FormState> formDeleteKey = GlobalKey<FormState>();

class DeleteSettings extends StatefulWidget {
  const DeleteSettings({super.key});

  @override
  State<DeleteSettings> createState() => _DeleteSettingsState();
}

class _DeleteSettingsState extends State<DeleteSettings> {
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    formDeleteKey.currentState?.dispose();
    passwordSettingController.dispose();
    deleteSettingController.dispose();
  }

  final passwordSettingController = TextEditingController();
  final deleteSettingController = TextEditingController();

  // Unlink Mirror
  Future unlinkMirror() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('pinLock', false);
    try {
      final dbRef = FirebaseDatabase.instance
          .ref('users/${FirebaseAuth.instance.currentUser!.uid}/linkedMirror');
      DatabaseEvent event = await dbRef.once();
      if (event.snapshot.value != null) {
        final dbRef2 =
            FirebaseDatabase.instance.ref('mirrors/${event.snapshot.value}');
        await dbRef2.update({'uid': 'none'});
        await dbRef2.update({'refreshToken': 'none'});
        await dbRef2.update({'idToken': 'none'});
        await dbRef.remove();
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to unlink mirror: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 10)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(seconds: 10),
                        curve: Curves.easeInOut,
                        builder: (context, double value, child) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Text((value * 10 - 11).abs().toInt().toString()),
                              CircularProgressIndicator(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                                value: value,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            ],
                          );
                        }),
                    const SizedBox(height: 20),
                    const Text(
                      'Are you sure you want to delete your account? \n If you are sure wait for 10 seconds.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FilledButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            );
          }
          return StatefulBuilder(builder: (context, setLocalState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Delete account'),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  if (formDeleteKey.currentState!.validate()) {
                    setLocalState(() {
                      loading = true;
                    });
                    try {
                      await FirebaseAuth.instance.currentUser!
                          .reauthenticateWithCredential(
                        EmailAuthProvider.credential(
                          email: FirebaseAuth.instance.currentUser!.email!,
                          password: passwordSettingController.text,
                        ),
                      );
                      await unlinkMirror();
                      await FirebaseAuth.instance.currentUser!.delete();
                      if (mounted) {
                        setLocalState(() {
                          loading = false;
                        });
                        context.go('/auth');
                      }
                    } on FirebaseAuthException catch (e) {
                      setLocalState(() {
                        loading = false;
                      });
                      debugPrint(e.code);
                      if (e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Wrong password.'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Something went wrong. Try again.'),
                          ),
                        );
                      }
                    }
                  }
                },
                label: const Text('Delete'),
                foregroundColor: Theme.of(context).colorScheme.onError,
                backgroundColor: Theme.of(context).colorScheme.error,
                icon: loading
                    ? SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onError,
                          strokeWidth: 2,
                        ))
                    : const Icon(Icons.chevron_right_rounded),
              ),
              body: Form(
                key: formDeleteKey,
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        validator: validatePassword,
                        controller: passwordSettingController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'You password',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        validator: validateDelete,
                        controller: deleteSettingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Type "DELETE" to confirm',
                        ),
                      ),
                    ),
                    const ListTile(
                      title: Text(
                        'Warning, this action is irreversible. If you delete your account you will lose all your data.',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
