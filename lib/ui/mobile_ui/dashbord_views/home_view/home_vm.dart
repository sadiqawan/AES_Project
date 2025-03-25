import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/cont_text.dart';
import '../../../../widgets/custom_snakBar.dart';

class HomeScreenController extends GetxController {
  final auth = FirebaseAuth.instance.currentUser!.uid;
  final fireStore = FirebaseFirestore.instance;

  TextEditingController nameC = TextEditingController();
  TextEditingController serialNoC = TextEditingController();
  TextEditingController costC = TextEditingController();
  TextEditingController modelC = TextEditingController();
  TextEditingController quantityC = TextEditingController();
  TextEditingController conditionC = TextEditingController();

  RxString selectedItem = ''.obs;
  RxBool selectedTimeOn = true.obs;
  RxBool isLoading = false.obs;
  RxString selectedDate = ''.obs;
  RxInt itemSelectIndex = (-1).obs;

  List<String> list = ['Switch', 'Router', 'FireWall', 'Server', 'Other'];

  // Date Picker
  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedDate.value = "${picked.year}-${picked.month}-${picked.day}";
      selectedTimeOn.value = true;
    }
  }

  // **Input Validation Function**
  bool validateInputs() {
    if (selectedItem.value.isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseSelectItem);
      return false;
    }
    if (nameC.text.trim().isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseEnterNameOfItem);
      return false;
    }
    if (serialNoC.text.trim().isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseEnterSerialNo);
      return false;
    }
    if (modelC.text.trim().isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseEnterModelNo);
      return false;
    }
    if (conditionC.text.trim().isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseConditionOfItem);
      return false;
    }
    if (costC.text.trim().isEmpty ||
        double.tryParse(costC.text.trim()) == null) {
      ErrorSnackbar.show(title: failed, message: pleaseEnterCostOfItem);
      return false;
    }
    if (quantityC.text.trim().isEmpty ||
        int.tryParse(quantityC.text.trim()) == null) {
      ErrorSnackbar.show(title: failed, message: pleaseEnterQuantityOfItem);
      return false;
    }
    if (selectedDate.value.isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseSelectDate);
      return false;
    }
    if (itemSelectIndex.value == -1) {
      ErrorSnackbar.show(title: failed, message: pleaseSelectItemType);
      return false;
    }
    return true;
  }

  Future<void> updateAvailableStock(String id, int upCost, int upQau) async {
    if (!validateInputs()) return;

    isLoading.value = true;
    final name = nameC.text.trim();
    final serial = serialNoC.text.trim();
    final cost = costC.text.trim();
    final quantity = quantityC.text.trim();
    final model = modelC.text.trim();
    final condition = conditionC.text.trim();

    final parsCost = int.tryParse(cost);
    final parsQuan = int.tryParse(quantity);
    final finalCost = parsCost! + upCost;
    final finalQuan = parsQuan! + upQau;

    try {
      DocumentSnapshot userDoc =
          await fireStore.collection('users').doc(auth).get();
      String entryBy =
          userDoc.exists ? userDoc['name'] ?? 'Unknown User' : 'Unknown User';

      Map<int, String> itemCollections = {
        0: 'switches',
        1: 'routers',
        2: 'firewalls',
        3: 'servers',
        4: 'others',
      };

      String collectionName = itemCollections[itemSelectIndex.value] ?? '';

      // 🔹 Add history record
      String itemType = list[itemSelectIndex.value];

      Map<String, dynamic> historyData = {
        'itemType': itemType,
        'itemName': name,
        'serialNo': serial,
        'modelNo': model,
        'itemCost': finalCost,
        'itemQuantity': finalQuan,
        'entryDate': selectedDate.value,
        'entryBy': entryBy,
        'condition': condition,
        'status': 'Updated',
        'upDatedBy': entryBy,
        'dispatchBy': '-',

      };

      await fireStore
          .collection('allHistory')
          .doc('123')
          .collection('allData')
          .doc()
          .set(historyData);

      await fireStore
          .collection('allHistory')
          .doc('123')
          .collection(collectionName)
          .doc()
          .set(historyData);

      // 🔹 Update available stock
      Map<String, dynamic> stockData = {
        'itemType': itemType,
        'itemName': name,
        'serialNo': serial,
        'modelNo': model,
        'itemCost': finalCost,
        'itemQuantity': finalQuan,
        'entryDate': selectedDate.value,
        'entryBy': entryBy,
        'condition': condition,
        'upDatedBy': entryBy,
        'dispatchBy': '-',
      };

      await fireStore
          .collection('availableStock')
          .doc('456')
          .collection('allStock')
          .doc(id)
          .update(stockData);

      // 🔹 **Find and Update the Document Dynamically in collectionName**
      QuerySnapshot querySnapshot =
          await fireStore
              .collection('availableStock')
              .doc('456')
              .collection(collectionName)
              .where(
                'serialNo',
                isEqualTo: serial,
              ) // Use a unique field like serialNo
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId =
            querySnapshot.docs.first.id; // Get the document ID dynamically

        await fireStore
            .collection('availableStock')
            .doc('456')
            .collection(collectionName)
            .doc(docId)
            .update(stockData);
      } else {
        print("No matching document found for update.");
      }

      SuccessSnackbar.show(title: success, message: itemUpdatedSuccessfully);

      // Reset fields
      nameC.clear();
      serialNoC.clear();
      costC.clear();
      quantityC.clear();
      modelC.clear();
      conditionC.clear();
      selectedItem.value = '';
      selectedDate.value = '';
      itemSelectIndex.value = -1;
    } catch (e) {
      ErrorSnackbar.show(title: failed, message: "Failed to add item: $e");
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> dispatchAvailableStock(String id, int upCost, int upQau) async {
    if (!validateInputs()) return;

    isLoading.value = true;
    final name = nameC.text.trim();
    final serial = serialNoC.text.trim();
    final cost = costC.text.trim();
    final quantity = quantityC.text.trim();
    final model = modelC.text.trim();
    final condition = conditionC.text.trim();

    int? parsCost = int.tryParse(cost);
    int? parsQuan = int.tryParse(quantity);
    int finalCost = upCost - parsCost!;
    int finalQuan = upQau - parsQuan!;

    try {
      DocumentSnapshot userDoc =
          await fireStore.collection('users').doc(auth).get();
      String entryBy =
          userDoc.exists ? userDoc['name'] ?? 'Unknown User' : 'Unknown User';

      Map<int, String> itemCollections = {
        0: 'switches',
        1: 'routers',
        2: 'firewalls',
        3: 'servers',
        4: 'others',
      };

      String collectionName = itemCollections[itemSelectIndex.value] ?? '';

      // 🔹 Add history record
      String itemType = list[itemSelectIndex.value];

      Map<String, dynamic> historyData = {
        'itemType': itemType,
        'itemName': name,
        'serialNo': serial,
        'modelNo': model,
        'itemCost': finalCost,
        'itemQuantity': finalQuan,
        'entryDate': selectedDate.value,
        'entryBy': entryBy,
        'dispatchBy': entryBy,
        'condition': condition,
        'status': 'Dispatched',
        'upDatedBy': entryBy,

      };

      await fireStore
          .collection('allHistory')
          .doc('123')
          .collection('allData')
          .doc()
          .set(historyData);

      await fireStore
          .collection('allHistory')
          .doc('123')
          .collection(collectionName)
          .doc()
          .set(historyData);

      // 🔹 Update available stock
      Map<String, dynamic> stockData = {
        'itemType': itemType,
        'itemName': name,
        'serialNo': serial,
        'modelNo': model,
        'itemCost': finalCost,
        'itemQuantity': finalQuan,
        'entryDate': selectedDate.value,
        'entryBy': entryBy,
        'condition': condition,
        'upDatedBy': entryBy,
        'dispatchBy': entryBy,

      };

      await fireStore
          .collection('availableStock')
          .doc('456')
          .collection('allStock')
          .doc(id)
          .update(stockData);

      // 🔹 **Find and Update the Document Dynamically in collectionName**
      QuerySnapshot querySnapshot =
          await fireStore
              .collection('availableStock')
              .doc('456')
              .collection(collectionName)
              .where(
                'serialNo',
                isEqualTo: serial,
              ) // Use a unique field like serialNo
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId =
            querySnapshot.docs.first.id; // Get the document ID dynamically

        await fireStore
            .collection('availableStock')
            .doc('456')
            .collection(collectionName)
            .doc(docId)
            .update(stockData);
      } else {
        print("No matching document found for update.");
      }

      SuccessSnackbar.show(title: success, message: itemDispatchedSuccessfully);

      // Reset fields
      nameC.clear();
      serialNoC.clear();
      costC.clear();
      quantityC.clear();
      modelC.clear();
      conditionC.clear();
      selectedItem.value = '';
      selectedDate.value = '';
      itemSelectIndex.value = -1;
    } catch (e) {
      ErrorSnackbar.show(title: failed, message: "Failed to add item: $e");
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> updateAvailableStock(String id, int upCost,int upQau) async {
  //   if (!validateInputs()) return;
  //
  //   isLoading.value = true;
  //   final name = nameC.text.trim();
  //   final serial = serialNoC.text.trim();
  //   final cost = costC.text.trim();
  //   final quantity = quantityC.text.trim();
  //   final model = modelC.text.trim();
  //   final condition = conditionC.text.trim();
  //
  //   final parsCost = int.tryParse(cost);
  //   final parsQuan = int.tryParse(quantity);
  //   final finalCost = parsCost! + upCost;
  //   final finalQuan = parsQuan! + upQau;
  //
  //   try {
  //     DocumentSnapshot userDoc =
  //     await fireStore.collection('users').doc(auth).get();
  //     String entryBy =
  //     userDoc.exists ? userDoc['name'] ?? 'Unknown User' : 'Unknown User';
  //
  //     Map<int, String> itemCollections = {
  //       0: 'switches',
  //       1: 'routers',
  //       2: 'firewalls',
  //       3: 'servers',
  //       4: 'others',
  //     };
  //
  //     String collectionName = itemCollections[itemSelectIndex.value] ?? '';
  //
  //     // 🔹 Add history record
  //     String itemType = list[itemSelectIndex.value];
  //
  //     Map<String, dynamic> historyData = {
  //       'itemType': itemType,
  //       'itemName': name,
  //       'serialNo': serial,
  //       'modelNo': model,
  //       'itemCost': finalCost,
  //       'itemQuantity': finalQuan,
  //       'entryDate': selectedDate.value,
  //       'entryBy': entryBy,
  //       'condition': condition,
  //       'status': 'Update',
  //     };
  //
  //     await fireStore
  //         .collection('allHistory')
  //         .doc('123')
  //         .collection('allData')
  //         .doc()
  //         .set(historyData);
  //
  //     await fireStore
  //         .collection('allHistory')
  //         .doc('123')
  //         .collection(collectionName)
  //         .doc()
  //         .set(historyData);
  //
  //
  //     // 🔹 Create new item entry
  //     Map<String, dynamic> stockData = {
  //       'itemType': itemType,
  //       'itemName': name,
  //       'serialNo': serial,
  //       'modelNo': model,
  //       'itemCost': finalCost,
  //       'itemQuantity': finalQuan,
  //       'entryDate': selectedDate.value,
  //       'entryBy': entryBy,
  //       'condition': condition,
  //       'upDatedBy': entryBy,
  //     };
  //     await fireStore
  //         .collection('availableStock')
  //         .doc('456')
  //         .collection('allStock')
  //         .doc(id)
  //         .update(stockData);
  //
  //     await fireStore
  //         .collection('availableStock')
  //         .doc('456')
  //         .collection(collectionName)
  //         .doc()
  //         .update(stockData);
  //
  //
  //     SuccessSnackbar.show(title: success, message: itemAddedSuccessfully);
  //
  //     // Reset fields
  //     nameC.clear();
  //     serialNoC.clear();
  //     costC.clear();
  //     quantityC.clear();
  //     modelC.clear();
  //     conditionC.clear();
  //     selectedItem.value = '';
  //     selectedDate.value = '';
  //     itemSelectIndex.value = -1;
  //   } catch (e) {
  //     ErrorSnackbar.show(title: failed, message: "Failed to add item: $e");
  //     print(e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
