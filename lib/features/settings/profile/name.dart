import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/modules_post.dart';
import '../../../core/validators.dart';

GlobalKey<FormState> formNameKey = GlobalKey<FormState>();

class NameSettings extends StatefulWidget {
  const NameSettings({super.key});

  @override
  State<NameSettings> createState() => _NameSettingsState();
}

class _NameSettingsState extends State<NameSettings> {
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    formNameKey.currentState?.dispose();
    nameSettingController.dispose();
  }

  final nameSettingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (formNameKey.currentState!.validate()) {
            setState(() {
              loading = true;
            });
            try {
              await FirebaseAuth.instance.currentUser!
                  .updateDisplayName(nameSettingController.text);
              if (mounted) {
                setState(() {
                  displayName = nameSettingController.text;
                  nameSettingController.clear();
                  loading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Name updated.'),
                  ),
                );
              }
            } on FirebaseAuthException catch (e) {
              setState(() {
                loading = false;
              });
              debugPrint(e.code);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong. Try again.'),
                ),
              );
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
        key: formNameKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                initialValue: FirebaseAuth.instance.currentUser!.displayName!,
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Your current name',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                validator: validateFirstName,
                controller: nameSettingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'New name',
                ),
              ),
            ),
            const ListTile(
              title: Text(
                'Your name will be changed in the compliment module as well.',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
