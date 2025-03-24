import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mode sombre',
                    style: TextStyle(fontSize: 16),
                  ),
                  FlutterSwitch(
                    width: 45.0,
                    height: 25.0,
                    value: themeProvider.isDarkMode,
                    onToggle: (value) {
                      themeProvider.toggleTheme();
                    },
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          const Text(
            'À propos de l\'application',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Version 1.0.0\n\n'
            'Cette application permet de suivre votre traitement à la L-glutamine '
            'et d\'exporter vos données pour un suivi médical optimal.',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}