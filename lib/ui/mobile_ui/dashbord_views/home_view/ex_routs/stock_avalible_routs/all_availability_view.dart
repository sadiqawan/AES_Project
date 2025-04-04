import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllAvailabilityView extends StatefulWidget {
  const AllAvailabilityView({super.key});

  @override
  State<AllAvailabilityView> createState() => _AllAvailabilityViewState();
}

class _AllAvailabilityViewState extends State<AllAvailabilityView> {
  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}
Widget _screen(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: const Text('Available Stock')),
    body: StreamBuilder(
      stream: FirebaseFirestore.instance
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

        var historyData = snapshot.data!.docs;

        return ListView(
          children: [
          SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                return DataRow(cells: [
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
                  DataCell(Text(data['dispatchTo'] ?? 'N/A')),

                ]);
              }),
            ),
          ),
        )
          ],
        );
      },
    ),

  );
}