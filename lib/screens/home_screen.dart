import 'package:flutter/material.dart';
import '../models/suivi_journalier.dart';
import '../services/database_service.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SuiviJournalier> _suivis = [];

  @override
  void initState() {
    super.initState();
    _loadSuivis();
  }

  Future<void> _loadSuivis() async {
    final suivis = await DatabaseService.instance.getAllSuivis();
    setState(() {
      _suivis = suivis;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suivi Traitement'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadSuivis,
          ),
        ],
      ),
      body: _suivis.isEmpty
          ? const Center(
              child: Text('Aucun suivi enregistré'),
            )
          : ListView.builder(
              itemCount: _suivis.length,
              itemBuilder: (context, index) {
                final suivi = _suivis[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: ExpansionTile(
                    title: Text(
                      '${suivi.date.day}/${suivi.date.month}/${suivi.date.year}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Poids: ${suivi.poids} kg'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow('Tension artérielle', suivi.tensionArterielle),
                            _buildInfoRow('État digestif', suivi.etatDigestif),
                            _buildInfoRow('Douleurs articulaires', '${suivi.douleursArticulaires}/10'),
                            _buildInfoRow('Évolution ulcération', suivi.evolutionUlceration),
                            _buildInfoRow('Prise L-glutamine', suivi.priseGlutamine),
                            if (suivi.effetsSecondaires.isNotEmpty)
                              _buildInfoRow('Effets secondaires', suivi.effetsSecondaires),
                            if (suivi.observations.isNotEmpty)
                              _buildInfoRow('Observations', suivi.observations),
                            const SizedBox(height: 8),
                            const Text(
                              'Repas de la journée:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildMealIndicator('Petit-déjeuner', suivi.petitDejeuner),
                                _buildMealIndicator('Déjeuner', suivi.dejeuner),
                                _buildMealIndicator('Collation', suivi.collation),
                                _buildMealIndicator('Dîner', suivi.diner),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormScreen()),
          );
          _loadSuivis();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildMealIndicator(String label, bool value) {
    return Column(
      children: [
        Icon(
          value ? Icons.check_circle : Icons.cancel,
          color: value ? Colors.green : Colors.red,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}