import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class PdfService {
  static Future<File> generatePdf(String title, List<Map<String, String>> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(title, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['Date', 'Work Hours', 'Break Hours', 'Total Hours'],
                data: data.map((entry) => [entry['date'], entry['work'], entry['break'], entry['total']]).toList(),
              ),
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/schedule_report.pdf');
    await file.writeAsBytes(await pdf.save());
    
    return file;
  }

  static Future<void> openPdf(File file) async {
    await OpenFile.open(file.path);
  }
}
