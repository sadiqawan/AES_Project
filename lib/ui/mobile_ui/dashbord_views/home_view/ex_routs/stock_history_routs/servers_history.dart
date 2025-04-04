import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;
import '../../../../../../constant/cont_colors.dart';
class ServersHistoryView extends StatefulWidget {
  const ServersHistoryView({super.key});

  @override
  State<ServersHistoryView> createState() => _ServersHistoryViewState();
}

class _ServersHistoryViewState extends State<ServersHistoryView> {
  List<QueryDocumentSnapshot> historyData = [];

  Future<void> _generatePDF() async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4.landscape,
          build: (pw.Context context) => [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Azoure Servers History Report',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  "Printed at: ${DateTime.now().toString()}",
                  style: pw.TextStyle(fontSize: 10),
                ),
                pw.SizedBox(height: 10),
              ],
            ),
            pw.TableHelper.fromTextArray(
              headers: [
                'Index', 'Type', 'S.No', 'Model', 'Name', 'Condition',
                'Quantity', 'Cost', 'Added By', 'Date', 'Stock Updated By',
                'Dispatch By', 'Dispatch To'
              ],
              data: List.generate(historyData.length, (index) {
                var data = historyData[index];
                return [
                  '${index + 1}',
                  data['itemType'] ?? 'N/A',
                  data['serialNo'] ?? 'N/A',
                  data['modelNo'] ?? 'N/A',
                  data['itemName'] ?? 'N/A',
                  data['condition'] ?? 'N/A',
                  data['itemQuantity'].toString(),
                  data['itemCost'].toString(),
                  data['entryBy'] ?? 'N/A',
                  data['entryDate'] ?? 'N/A',
                  data['upDatedBy'] ?? 'N/A',
                  data['dispatchBy'] ?? 'N/A',
                  data['dispatchTo'] ?? 'N/A',
                ];
              }),
              border: pw.TableBorder.all(width: 0.5),
              headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
              headerStyle: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
              cellStyle: pw.TextStyle(fontSize: 8),
              cellAlignment: pw.Alignment.centerLeft,
              columnWidths: {
                0: pw.FixedColumnWidth(30),
                1: pw.FixedColumnWidth(50),
                2: pw.FixedColumnWidth(40),
                3: pw.FixedColumnWidth(50),
                4: pw.FixedColumnWidth(60),
                5: pw.FixedColumnWidth(50),
                6: pw.FixedColumnWidth(40),
                7: pw.FixedColumnWidth(50),
                8: pw.FixedColumnWidth(60),
                9: pw.FixedColumnWidth(50),
                10: pw.FixedColumnWidth(60),
                11: pw.FixedColumnWidth(60),
                12: pw.FixedColumnWidth(60),
              },
            ),
          ],
        ),
      );

      final Uint8List pdfBytes = await pdf.save();

      if (kIsWeb) {
        final blob = html.Blob([pdfBytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', 'All_History.pdf')
          ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        late String filePath;
        if (Platform.isAndroid || Platform.isIOS) {
          final directory = await getApplicationDocumentsDirectory();
          filePath = '${directory.path}/All_History.pdf';
        } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
          final directory = await getDownloadsDirectory();
          if (directory != null) {
            filePath = '${directory.path}/All_History.pdf';
          } else {
            throw Exception("Failed to find a valid directory.");
          }
        } else {
          throw Exception("Unsupported platform.");
        }
        final file = File(filePath);
        await file.writeAsBytes(pdfBytes);
        await Printing.sharePdf(bytes: pdfBytes, filename: 'All_History.pdf');
      }
    } catch (e) {
      print("Error generating PDF: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Servers History')),
      body: StreamBuilder(
        stream:
        FirebaseFirestore.instance
            .collection('allHistory')
            .doc('123')
            .collection('servers')
            .orderBy('timestamp',)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Data Available'));
          }

          historyData = snapshot.data!.docs;

          return ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Allow horizontal scrolling
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    sortAscending: true,
                    columnSpacing: 15,
                    columns: const [
                      DataColumn(label: Text('Index')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('S.No')),
                      DataColumn(label: Text('Model')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Condition')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Cost')),
                      DataColumn(label: Text('Added By')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Stock updated By')),
                      DataColumn(label: Text('Dispatch By')),
                      DataColumn(label: Text('Dispatch To')),
                    ],
                    rows: List.generate(historyData.length, (index) {
                      var data = historyData[index];
                      return DataRow(
                        cells: [
                          DataCell(Text('${index + 1}')),
                          DataCell(Text(data['itemType'] ?? 'N/A')),
                          DataCell(Text(data['serialNo'] ?? 'N/A')),
                          DataCell(Text(data['modelNo'] ?? 'N/A')),
                          DataCell(Text(data['itemName'] ?? 'N/A')),
                          DataCell(Text(data['condition'] ?? 'N/A')),
                          DataCell(Text(data['itemQuantity'].toString())),
                          DataCell(Text(data['itemCost'].toString())),
                          DataCell(Text(data['entryBy'] ?? 'N/A')),
                          DataCell(Text(data['entryDate'] ?? 'N/A')),
                          DataCell(Text(data['upDatedBy'] ?? 'N/A')),
                          DataCell(Text(data['dispatchBy'] ?? 'N/A')),
                          DataCell(Text(data['dispatchBy'] ?? 'N/A')),
                        ],
                      );
                    }),
                  ),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBlack,
        onPressed: _generatePDF,
        child: const Icon(Icons.download, color: kWhite),
      ),
    );
  }
}


