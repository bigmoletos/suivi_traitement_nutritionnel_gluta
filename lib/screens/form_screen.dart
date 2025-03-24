import 'package:flutter/material.dart';
import '../models/suivi_journalier.dart';
import '../services/database_service.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _poidsController = TextEditingController();
  final _tensionController = TextEditingController();
  final _etatDigestifController = TextEditingController();
  final _evolutionController = TextEditingController();
  final _priseGlutamineController = TextEditingController();
  final _effetsSecondairesController = TextEditingController();
  final _observationsController = TextEditingController();

  int _douleursArticulaires = 0;
  bool _petitDejeuner = false;
  bool _dejeuner = false;
  bool _collation = false;
  bool _diner = false;

  @override
  void dispose() {
    _poidsController.dispose();
    _tensionController.dispose();
    _etatDigestifController.dispose();
    _evolutionController.dispose();
    _priseGlutamineController.dispose();
    _effetsSecondairesController.dispose();
    _observationsController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final suivi = SuiviJournalier(
        date: DateTime.now(),
        poids: double.parse(_poidsController.text),
        tensionArterielle: _tensionController.text,
        etatDigestif: _etatDigestifController.text,
        douleursArticulaires: _douleursArticulaires,
        evolutionUlceration: _evolutionController.text,
        priseGlutamine: _priseGlutamineController.text,
        effetsSecondaires: _effetsSecondairesController.text,
        observations: _observationsController.text,
        petitDejeuner: _petitDejeuner,
        dejeuner: _dejeuner,
        collation: _collation,
        diner: _diner,
      );

      await DatabaseService.instance.insertSuivi(suivi);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Suivi enregistré avec succès')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau Suivi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Repas de la journée
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Repas de la journée',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      CheckboxListTile(
                        title: const Text('Petit-déjeuner'),
                        value: _petitDejeuner,
                        onChanged: (value) {
                          setState(() {
                            _petitDejeuner = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Déjeuner'),
                        value: _dejeuner,
                        onChanged: (value) {
                          setState(() {
                            _dejeuner = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Collation'),
                        value: _collation,
                        onChanged: (value) {
                          setState(() {
                            _collation = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Dîner'),
                        value: _diner,
                        onChanged: (value) {
                          setState(() {
                            _diner = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Données de suivi
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Données de suivi',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _poidsController,
                        decoration: const InputDecoration(
                          labelText: 'Poids (kg)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre poids';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Veuillez entrer un nombre valide';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _tensionController,
                        decoration: const InputDecoration(
                          labelText: 'Tension artérielle',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre tension artérielle';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _etatDigestifController,
                        decoration: const InputDecoration(
                          labelText: 'État digestif',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez décrire votre état digestif';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text('Douleurs articulaires (0-10):'),
                      Slider(
                        value: _douleursArticulaires.toDouble(),
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: _douleursArticulaires.toString(),
                        onChanged: (value) {
                          setState(() {
                            _douleursArticulaires = value.round();
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _evolutionController,
                        decoration: const InputDecoration(
                          labelText: 'Évolution ulcération',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez décrire l\'évolution de l\'ulcération';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _priseGlutamineController,
                        decoration: const InputDecoration(
                          labelText: 'Prise de L-glutamine',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez décrire la prise de L-glutamine';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _effetsSecondairesController,
                        decoration: const InputDecoration(
                          labelText: 'Effets secondaires',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _observationsController,
                        decoration: const InputDecoration(
                          labelText: 'Observations générales',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}