import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/images.dart';
import '../../main.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then((value) {
      setState(() {
        isSupported = value;
      });
    });
  }

  // FingerPrint method
  final LocalAuthentication auth = LocalAuthentication();
  bool isSupported = false;
  Future<void> getAvailableBiometrics(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final availableBiometrics = await auth.getAvailableBiometrics();
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Confim your identity to authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          ));
      debugPrint('Authenticated: $authenticated');
      if (authenticated) {
        if (mounted) {
          setState(() {
            prefs.setBool('pinLock', value);
            pinLock = value;
          });
        }
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to authenticate: $e');
    }
    debugPrint('Available biometrics: $availableBiometrics');
  }

  // Sign out method
  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('pinLock', false);
    pinLock = false;
    if (mounted) {
      context.go('/auth');
    }
    await FirebaseAuth.instance.signOut();
  }

  // Unlink mirror method
  Future unlinkMirror() async {
    try {
      final dbRef = FirebaseDatabase.instance
          .ref('users/${FirebaseAuth.instance.currentUser!.uid}/linkedMirror');
      DatabaseEvent event = await dbRef.once();
      if (event.snapshot.value == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('You have no mirror linked!')));
        }
      } else {
        final dbRef2 =
            FirebaseDatabase.instance.ref('mirrors/${event.snapshot.value}');
        await dbRef2.update({'uid': 'none'});
        await dbRef2.update({'refreshToken': 'none'});
        await dbRef2.update({'idToken': 'none'});
        await dbRef.remove();
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Mirror unlinked!')));
        }
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to unlink mirror: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong. Try again.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.all(8),
      physics: const ClampingScrollPhysics(),
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          shadowColor: Colors.transparent,
          child: ListTile(
            leading: const Icon(Icons.face),
            title:
                Text('Hello ${FirebaseAuth.instance.currentUser!.displayName}'),
            subtitle: const Text('Profile settings'),
            trailing: const Icon(Icons.settings),
            onTap: () {
              context.push('/settings/profile');
            },
          ),
        ),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.dark_mode_outlined),
              title: const Text('System theme'),
              onTap: () {
                context.push('/settings/dark_mode');
              },
            )),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.link_off),
              title: const Text('Unlink the mirror'),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Unlink Mirror'),
                        icon: const Icon(Icons.link_off),
                        content: const Text(
                            'Are you sure you want to unlink the mirror?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          FilledButton(
                              onPressed: () {
                                unlinkMirror();
                                Navigator.pop(context);
                              },
                              child: const Text('Unlink'))
                        ],
                      );
                    });
              },
            )),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.qr_code),
              title: const Text('Scan Mirror'),
              onTap: () {
                context.push('/password_scanner');
              },
            )),
        if (isSupported)
          Card(
              elevation: 2,
              shadowColor: Colors.transparent,
              child: ListTile(
                trailing: Switch(
                  value: pinLock,
                  onChanged: (value) {
                    getAvailableBiometrics(value);
                  },
                ),
                leading: const Icon(Icons.fingerprint),
                title: const Text('Pin lock'),
              )),
        const Divider(
          height: 30,
          indent: 20,
          endIndent: 20,
        ),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy Policy'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Your informations are safe! Don\'t worry :)'),
                ));
              },
            )),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.support),
              title: const Text('Support'),
              onTap: () {
                context.push('/settings/support');
              },
            )),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationIcon: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Image.asset(
                        isDark(context, logo['dark'], logo['light']),
                        height: 34,
                      ),
                    ),
                    applicationName: 'What a Mirror',
                    applicationVersion: '1.0.0',
                    children: const [
                      Text(
                          'Application developed by Adem Othman, a student at the Higher Institute of Computer Science and Communication Technologies of Hammam Sousse.')
                    ]);
              },
            )),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.logout),
              leading: const Icon(Icons.lock),
              title: const Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const Icon(Icons.logout),
                    title: const Text('Are you sure?'),
                    content: const Text('Do you want to logout?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            signOut();
                          },
                          child: const Text('Yes')),
                    ],
                  ),
                );
              },
            )),
      ],
    ));
  }
}
