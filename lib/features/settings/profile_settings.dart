import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(
            leading: const Icon(Icons.face),
            title: const Text('Name'),
            trailing: IconButton(
              onPressed: () {
                context.push('/settings/profile/name');
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            subtitle: Text(FirebaseAuth.instance.currentUser!.displayName!),
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline_rounded),
            title: const Text('Password'),
            trailing: IconButton(
              onPressed: () {
                context.push('/settings/profile/password');
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            subtitle: const Text('Change your password'),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
            height: 30,
          ),
          ListTile(
            leading: Icon(
              Icons.warning_amber_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              'Delete Account',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                context.push('/settings/profile/delete_account');
              },
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            subtitle: Text(
              'Delete your account',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
          const ListTile(
            leading: Text(
                'When changing your informations, there is chance the mirror may unlink from your account.'),
          ),
        ],
      ),
    );
  }
}
