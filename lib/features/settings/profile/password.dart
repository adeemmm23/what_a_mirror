import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/validators.dart';

GlobalKey<FormState> formPasswordChangeKey = GlobalKey<FormState>();

class PasswordSettings extends StatefulWidget {
  const PasswordSettings({super.key});

  @override
  State<PasswordSettings> createState() => _PasswordSettingsState();
}

class _PasswordSettingsState extends State<PasswordSettings> {
  bool obscureText = true;
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    formPasswordChangeKey.currentState?.dispose();
    passwordOldSettingsController.dispose();
    passwordNewSettingsController.dispose();
    passwordConfirmSettingsController.dispose();
  }

  final passwordOldSettingsController = TextEditingController();
  final passwordNewSettingsController = TextEditingController();
  final passwordConfirmSettingsController = TextEditingController();

  // Unlink Mirror
  Future unlinkMirror() async {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (formPasswordChangeKey.currentState!.validate()) {
            setState(() {
              loading = true;
            });
            try {
              await FirebaseAuth.instance.currentUser!
                  .reauthenticateWithCredential(
                EmailAuthProvider.credential(
                  email: FirebaseAuth.instance.currentUser!.email!,
                  password: passwordOldSettingsController.text,
                ),
              );
              await FirebaseAuth.instance.currentUser!
                  .updatePassword(passwordNewSettingsController.text);
              passwordConfirmSettingsController.clear();
              passwordNewSettingsController.clear();
              passwordOldSettingsController.clear();
              await unlinkMirror();
              if (mounted) {
                setState(() {
                  loading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password updated.'),
                  ),
                );
              }
            } on FirebaseAuthException catch (e) {
              setState(() {
                loading = false;
              });
              if (e.code == 'wrong-password') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Your old password is incorrect.'),
                  ),
                );
              } else if (e.code == 'network-request-failed') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Check your internet connection.'),
                  ),
                );
              } else {
                debugPrint(e.code);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Something went wrong. Try again.'),
                  ),
                );
              }
            }
          }
        },
        label: const Text('Save'),
        icon: loading
            ? SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  strokeWidth: 2,
                ))
            : const Icon(Icons.chevron_right_rounded),
      ),
      body: Form(
        key: formPasswordChangeKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                obscureText: obscureText,
                keyboardType: TextInputType.visiblePassword,
                validator: validatePassword,
                controller: passwordOldSettingsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Old password',
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                obscureText: obscureText,
                keyboardType: TextInputType.visiblePassword,
                validator: validatePassword,
                controller: passwordNewSettingsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'New password',
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                obscureText: obscureText,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordConfirmSettingsController,
                validator: (val) =>
                    validateRepeatPassword(val, passwordNewSettingsController),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Confirm new password',
                ),
              ),
            ),
            const SizedBox(height: 15),
            const ListTile(
              title: Text(
                'When changing your password, the mirror will be unlinked. Use the Scan Mirror to link it again.',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            Center(
                child: TextButton.icon(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              label: const Text('Show password'),
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
