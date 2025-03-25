import 'package:ase/constant/cont_colors.dart';
import 'package:ase/extensions/size_box.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/add_dispaichs_view/add_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/add_dispaichs_view/dispatch_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/home_vm.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constant/const_style.dart';
import '../../../../../../widgets/costum_button.dart';

class AddDispatchView extends StatefulWidget {
  const AddDispatchView({super.key});

  @override
  State<AddDispatchView> createState() => _AddDispatchViewState();
}

class _AddDispatchViewState extends State<AddDispatchView> {
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add & Dispatch')),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance
                .collection('availableStock')
                .doc('456')
                .collection('allStock')
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

/*
import 'package:ase/constant/cont_colors.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/item_listing_view/add_item_vm.dart';
import 'package:ase/widgets/costum_button.dart';
import 'package:ase/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDispatchView extends StatefulWidget {
  const AddDispatchView({super.key});

  @override
  State<AddDispatchView> createState() => _AddDispatchViewState();
}

class _AddDispatchViewState extends State<AddDispatchView> {
  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}


Widget _screen(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: const Text('Add & Dispatch')),
    body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('availableStock').doc('456').collection('allStock').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Data Available'));
        }
        var historyData = snapshot.data!.docs;

        final cost = historyData['Cost'];
        final quantity = historyData['Quantity'];
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
                    onLongPress:  (){
                      Get.bottomSheet(
                        Container(
                          color:  kSecondaryColor,
                          child: Column(
                            children: [
                              CustomTextField(hint: quantity, controller: controller, icon: Icons.add),
                              CustomTextField(hint: cost, controller: controller, icon: Icons.add),

                              CustomButton(title: 'Add', onTap: (){}),
                              CustomButton(title: 'Dispatch', onTap: (){}),
                            ],
                          ),
                        )

                      );
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

                ]);
              }),
            ),
          ),
        );
      },
    ),
  );
}*/
