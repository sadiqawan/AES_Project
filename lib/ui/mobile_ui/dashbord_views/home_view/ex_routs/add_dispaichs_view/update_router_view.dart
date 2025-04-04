import 'package:ase/extensions/size_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constant/const_style.dart';
import '../../../../../../constant/cont_colors.dart';
import '../../../../../../widgets/costum_button.dart';
import 'add_view.dart';
import 'dispatch_view.dart';

class UpdateRouterView extends StatefulWidget {
  const UpdateRouterView({super.key});

  @override
  State<UpdateRouterView> createState() => _UpdateRouterViewState();
}

class _UpdateRouterViewState extends State<UpdateRouterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Routers')),
      body: StreamBuilder(
        stream:
        FirebaseFirestore.instance
            .collection('availableStock')
            .doc('456')
            .collection('routers')
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
                  final _type = data['itemType'] ?? 'N/A';
                  final _name = data['itemName'] ?? 'N/A';
                  final _model = data['modelNo'] ?? 'N/A';
                  final _sNo = data['serialNo'] ?? 'N/A';
                  final _quantity = data['itemQuantity'].toString();
                  final _const = data['itemCost'].toString();
                  final _id = data.id;
                  return DataRow(
                    onLongPress: () {
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Update Stock', style: kSubTitle2B),

                              CustomButton(
                                title: 'Update',
                                onTap: () {
                                  Navigator.pop(context);
                                  Get.to(
                                    AddView(
                                      type: _type,
                                      name: _name,
                                      model: _model,
                                      quantity: _quantity,
                                      cost: _const,
                                      sNo: _sNo,
                                      id: _id,
                                    ),
                                  );
                                },
                              ),
                              10.height,
                              CustomButton(
                                title: 'Dispatch',
                                onTap: () {
                                  Navigator.pop(context);
                                  Get.to(
                                    DispatchView(
                                      type: _type,
                                      name: _name,
                                      model: _model,
                                      quantity: _quantity,
                                      cost: _const,
                                      sNo: _sNo,
                                      id: _id,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                      /*controller.openBottomSheet(
                        data.id,
                        data['itemQuantity'].toString(),
                        data['itemCost'].toString(),
                        data['itemType'].toString(),
                      );*/
                    },
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
    );

  }
}
