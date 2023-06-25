import 'package:flutter/material.dart';
import '../../main.dart';

class DarkMode extends StatefulWidget {
  const DarkMode({super.key});

  @override
  State<DarkMode> createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Theme'),
      ),
      body: Center(
        child: ListView(padding: const EdgeInsets.all(8), children: [
          ListTile(
            trailing: Radio(
              value: ThemeMode.dark,
              groupValue: currentTheme,
              onChanged: (value) {
                setState(() {
                  themeManager.toggleThemeMode(ThemeMode.dark);
                });
              },
            ),
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Dark Mode'),
          ),
          ListTile(
            trailing: Radio(
              value: ThemeMode.light,
              groupValue: currentTheme,
              onChanged: (value) {
                setState(() {
                  themeManager.toggleThemeMode(value);
                });
              },
            ),
            leading: const Icon(Icons.wb_sunny_outlined),
            title: const Text('Light Mode'),
          ),
          ListTile(
            trailing: Radio(
              value: ThemeMode.system,
              groupValue: currentTheme,
              onChanged: (value) {
                setState(() {
                  themeManager.toggleThemeMode(value);
                });
              },
            ),
            leading: const Icon(Icons.phone_android_outlined),
            title: const Text('System Mode'),
          ),
          const ListTile(
            title: Text(
              'when system mode is selected, the app will follow your device theme.',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
