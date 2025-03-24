import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/suivi_journalier.dart';
import 'database_service.dart';

class ExportService {
  static Future<void> exportToPDF() async {
    final List<SuiviJournalier> suivis = await DatabaseService.instance.getAllSuivi();

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'Suivi Journalier L-Glutamine',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 20),
          ...suivis.map((suivi) => pw.Container(
            margin: pw.EdgeInsets.only(bottom: 20),
            padding: pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Date: ${suivi.date.toString().split(' ')[0]}'),
                pw.Text('Poids: ${suivi.poids} kg'),
                pw.Text('Tension artérielle: ${suivi.tensionArterielle}'),
                pw.Text('État digestif: ${suivi.etatDigestif}'),
                pw.Text('Douleurs articulaires: ${suivi.douleursArticulaires}/10'),
                pw.Text('Évolution ulcération: ${suivi.evolutionUlceration}'),
                pw.Text('Prise de L-glutamine: ${suivi.priseGlutamine}'),
                pw.Text('Effets secondaires: ${suivi.effetsSecondaires}'),
                pw.Text('Observations: ${suivi.observations}'),
              ],
            ),
          )),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/suivi_glutamine.pdf');
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles([XFile(file.path)]);
  }

  static Future<void> exportToCSV() async {
    final List<SuiviJournalier> suivis = await DatabaseService.instance.getAllSuivi();

    String csv = 'Date,Poids,Tension artérielle,État digestif,Douleurs articulaires,Évolution ulcération,Prise L-glutamine,Effets secondaires,Observations\n';

    for (var suivi in suivis) {
      csv += '${suivi.date.toString().split(' ')[0]},${suivi.poids},${suivi.tensionArterielle},${suivi.etatDigestif},${suivi.douleursArticulaires},${suivi.evolutionUlceration},${suivi.priseGlutamine},${suivi.effetsSecondaires},${suivi.observations}\n';
    }

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/suivi_glutamine.csv');
    await file.writeAsString(csv);

    await Share.shareXFiles([XFile(file.path)]);
  }
}