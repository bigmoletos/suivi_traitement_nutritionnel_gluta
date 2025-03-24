class SuiviJournalier {
  final int? id;
  final DateTime date;
  final double poids;
  final String tensionArterielle;
  final String etatDigestif;
  final int douleursArticulaires;
  final String evolutionUlceration;
  final String priseGlutamine;
  final String effetsSecondaires;
  final String observations;
  final bool petitDejeuner;
  final bool dejeuner;
  final bool collation;
  final bool diner;

  SuiviJournalier({
    this.id,
    required this.date,
    required this.poids,
    required this.tensionArterielle,
    required this.etatDigestif,
    required this.douleursArticulaires,
    required this.evolutionUlceration,
    required this.priseGlutamine,
    required this.effetsSecondaires,
    required this.observations,
    required this.petitDejeuner,
    required this.dejeuner,
    required this.collation,
    required this.diner,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'poids': poids,
      'tensionArterielle': tensionArterielle,
      'etatDigestif': etatDigestif,
      'douleursArticulaires': douleursArticulaires,
      'evolutionUlceration': evolutionUlceration,
      'priseGlutamine': priseGlutamine,
      'effetsSecondaires': effetsSecondaires,
      'observations': observations,
      'petitDejeuner': petitDejeuner ? 1 : 0,
      'dejeuner': dejeuner ? 1 : 0,
      'collation': collation ? 1 : 0,
      'diner': diner ? 1 : 0,
    };
  }

  factory SuiviJournalier.fromMap(Map<String, dynamic> map) {
    return SuiviJournalier(
      id: map['id'],
      date: DateTime.parse(map['date']),
      poids: map['poids'],
      tensionArterielle: map['tensionArterielle'],
      etatDigestif: map['etatDigestif'],
      douleursArticulaires: map['douleursArticulaires'],
      evolutionUlceration: map['evolutionUlceration'],
      priseGlutamine: map['priseGlutamine'],
      effetsSecondaires: map['effetsSecondaires'],
      observations: map['observations'],
      petitDejeuner: map['petitDejeuner'] == 1,
      dejeuner: map['dejeuner'] == 1,
      collation: map['collation'] == 1,
      diner: map['diner'] == 1,
    );
  }
}