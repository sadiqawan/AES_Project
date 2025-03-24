import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoutersHistoryView extends StatefulWidget {
  const RoutersHistoryView({super.key});

  @override
  State<RoutersHistoryView> createState() => _RoutersHistoryViewState();
}

class _RoutersHistoryViewState extends State<RoutersHistoryView> {
  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}
Widget _screen(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: const Text('Routers History')),
    body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('allHistory').doc('123').collection('routers').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Data Available'));
        }

        var historyData = snapshot.data!.docs;

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
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Cost')),
                DataColumn(label: Text('Added By')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Status')),
              ],
              rows: List.generate(historyData.length, (index) {
                var data = historyData[index];
                return DataRow(cells: [
                  DataCell(Text('${index + 1}')),
                  DataCell(Text(data['itemType'] ?? 'N/A')),
                  DataCell(Text(data['serialNo'] ?? 'N/A')),
                  DataCell(Text(data['modelNo'] ?? 'N/A')),
                  DataCell(Text(data['itemName'] ?? 'N/A')),
                  DataCell(Text(data['itemQuantity'].toString())),
                  DataCell(Text(data['itemCost'].toString())),
                  DataCell(Text(data['entryBy'] ?? 'N/A')),
                  DataCell(Text(data['entryDate'] ?? 'N/A')),
                  DataCell(Text(data['status'] ?? 'N/A')),
                ]);
              }),
            ),
          ),
        );
      },
    ),
  );

}
