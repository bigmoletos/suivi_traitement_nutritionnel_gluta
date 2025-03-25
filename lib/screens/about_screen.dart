import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À propos'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suivi L-Glutamine',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'À propos de l\'application',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Cette application a été conçue pour vous aider à suivre votre '
              'traitement à la L-glutamine. Elle vous permet de :\n\n'
              '• Enregistrer vos données quotidiennes\n'
              '• Suivre l\'évolution de votre traitement\n'
              '• Exporter vos données en PDF ou CSV\n'
              '• Personnaliser l\'interface (mode sombre/clair)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Contact',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Pour toute question ou suggestion, n\'hésitez pas à nous contacter :\n'
              'support@example.com',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Mentions légales',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '© 2024 Suivi L-Glutamine. Tous droits réservés.\n\n'
              'Cette application est destinée à un usage personnel et ne remplace '
              'pas les conseils de votre médecin traitant.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}