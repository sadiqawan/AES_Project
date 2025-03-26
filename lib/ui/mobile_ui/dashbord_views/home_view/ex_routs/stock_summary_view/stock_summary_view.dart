import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../../../constant/cont_colors.dart';

class StockSummaryView extends StatefulWidget {
  const StockSummaryView({super.key});

  @override
  State<StockSummaryView> createState() => _StockSummaryViewState();
}

class _StockSummaryViewState extends State<StockSummaryView> {
  List<QueryDocumentSnapshot> historyData = [];

  //PDF generator
  Future<void> _generatePDF() async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Stock Summary Report',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.TableHelper.fromTextArray(
                headers: [
                  'Index',
                  'Type',
                  'S.No',
                  'Model',
                  'Name',
                  'Status',
                  'QC',
                  'Cost',
                  'AddedBy',
                  'Date',
                ],
                headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                headerStyle: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
                cellStyle: pw.TextStyle(fontSize: 9),
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
                  ];
                }),
                border: pw.TableBorder.all(
                  color: PdfColors.black,
                  width: 0.5,
                ),
                cellAlignment: pw.Alignment.centerLeft,
                columnWidths: {
                  0: pw.FixedColumnWidth(30),
                  1: pw.FixedColumnWidth(50),
                  2: pw.FixedColumnWidth(40),
                  3: pw.FixedColumnWidth(50),
                  4: pw.FixedColumnWidth(50),
                  5: pw.FixedColumnWidth(50),
                  6: pw.FixedColumnWidth(40),
                  7: pw.FixedColumnWidth(40),
                  8: pw.FixedColumnWidth(60),
                  9: pw.FixedColumnWidth(60),
                },
              ),
            ],
          ),
        ),
      );

      final Uint8List pdfBytes = await pdf.save();

      if (kIsWeb) {
        // Web: Download the file using a Blob
        final blob = html.Blob([pdfBytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', 'Stock_Summary.pdf')
          ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        // Mobile/Desktop: Save the file locally
        late String filePath;
        if (Platform.isAndroid || Platform.isIOS) {
          final directory = await getApplicationDocumentsDirectory();
          filePath = '${directory.path}/Stock_Summary.pdf';
        } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
          final directory = await getDownloadsDirectory();
          if (directory != null) {
            filePath = '${directory.path}/Stock_Summary.pdf';
          } else {
            throw Exception("Failed to find a valid directory.");
          }
        } else {
          throw Exception("Unsupported platform.");
        }

        final file = File(filePath);
        await file.writeAsBytes(pdfBytes);

        // Open PDF or Share it
        await Printing.sharePdf(bytes: pdfBytes, filename: 'Stock_Summary.pdf');
      }

      print("PDF Generated Successfully!");
    } catch (e) {
      print("Error generating PDF: $e");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

      appBar: AppBar(title: const Text('Stock Summary')),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance
                .collection('availableStock')
                .doc('456')
                .collection('allStock')
                .orderBy('entryTimestamp')
                .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Data Available'));
          }

          historyData = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DataTable(
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
                    ],
                  );
                }),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBlack,
        onPressed: _generatePDF,
        child: const Icon(Icons.download, color: kWhite),
      ),
    );
  }
}
