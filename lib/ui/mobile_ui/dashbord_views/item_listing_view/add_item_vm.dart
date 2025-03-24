import 'package:ase/constant/cont_text.dart';
import 'package:ase/widgets/custom_snakBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemController extends GetxController {
  final auth = FirebaseAuth.instance.currentUser!.uid;
  final fireStore = FirebaseFirestore.instance;

  TextEditingController nameC = TextEditingController();
  TextEditingController serialNoC = TextEditingController();
  TextEditingController costC = TextEditingController();
  TextEditingController modelC = TextEditingController();
  TextEditingController quantityC = TextEditingController();

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

  Future<void> updateAllHistory() async {
    if (!validateInputs()) return;

    isLoading.value = true;

    final name = nameC.text.trim();
    final serial = serialNoC.text.trim();
    final cost = costC.text.trim();
    final quantity = quantityC.text.trim();
    final model = modelC.text.trim();

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

      await fireStore
          .collection('allHistory')
          .doc('123')
          .collection('allData')
          .doc()
          .set({
            'itemType': list[itemSelectIndex.value],
            'itemName': name,
            'serialNo': serial,
            'modelNo': model,
            'itemCost': cost,
            'itemQuantity': quantity,
            'entryDate': selectedDate.value,
            'entryBy': entryBy,
            'status': 'Added',

          });

      await fireStore
          .collection('allHistory')
          .doc('123')
          .collection(collectionName)
          .doc()
          .set({
            'itemType': list[itemSelectIndex.value],
            'itemName': name,
            'serialNo': serial,
            'modelNo': model,
            'itemCost': cost,
            'itemQuantity': quantity,
            'entryDate': selectedDate.value,
            'entryBy': entryBy,
            'status': 'Added',
          });

      SuccessSnackbar.show(title: success, message: itemAddedSuccessfully);

      // **Reset Fields**
      nameC.clear();
      serialNoC.clear();
      costC.clear();
      quantityC.clear();
      modelC.clear();
      selectedItem.value = '';
      selectedDate.value = '';
      itemSelectIndex.value = -1;
    } catch (e) {
      ErrorSnackbar.show(title: failed, message: "Failed to add item: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onTap() {
    print("Selected Index: ${itemSelectIndex.value}");
  }
}

/*import 'package:ase/constant/cont_text.dart';
import 'package:ase/widgets/custom_snakBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemController extends GetxController {
  final auth = FirebaseAuth.instance.currentUser!.uid;
  final fireStore = FirebaseFirestore.instance;

  TextEditingController nameC = TextEditingController();
  TextEditingController serialNoC = TextEditingController();
  TextEditingController costC = TextEditingController();
  TextEditingController quantityC = TextEditingController();

  RxString selectedItem = ''.obs;
  RxBool selectedTimeOn = true.obs;
  RxBool isLoading = false.obs;
  RxString selectedDate = ''.obs;
  RxInt itemSelectIndex = (-1).obs;

  List<String> list = ['Switch', 'Router', 'FireWall', 'Server', 'Other'];

  // Date picker
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

  Future<void> updateAllHistory() async {
    isLoading.value = true;

    final name = nameC.text.trim();
    final serial = serialNoC.text.trim();
    final cost = costC.text.trim();
    final quantity = quantityC.text.trim();

    DocumentSnapshot userDoc =
        await fireStore.collection('users').doc(auth).get();
    String entryBy =
        userDoc.exists ? userDoc['name'] ?? 'Unknown User' : 'Unknown User';

    // Validate Inputs
    if (selectedItem.value.isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseSelectItem);
      isLoading.value = false;
      return;
    }
    if (name.isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseEnterNameOfItem);
      isLoading.value = false;
      return;
    }
    if (serial.isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseEnterSerialNo);
      isLoading.value = false;
      return;
    }
    if (quantity.isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseEnterQuantityOfItem);
      isLoading.value = false;
      return;
    }
    if (itemSelectIndex.value == -1) {
      ErrorSnackbar.show(title: failed, message: pleaseSelectItemType);
      isLoading.value = false;
      return;
    }



    Map<int, String> itemCollections = {
      0: 'switches',
      1: 'routers',
      2: 'firewalls',
      3: 'servers',
      4: 'others',
    };

    String collectionName = itemCollections[itemSelectIndex.value] ?? '';

    if (collectionName.isEmpty) {
      ErrorSnackbar.show(title: failed, message: invalidItemSelected);
      isLoading.value = false;
      return;
    }

    try {
      // all recorded
      await fireStore
          .collection('allHistory')
          .doc()
          .collection('allData')
          .doc()
          .set({
        'itemType':
        list[itemSelectIndex.value],
        'itemName': name,
        'serialNo': serial,
        'itemCost': cost,
        'itemQuantity': quantity,
        'entryDate': selectedDate.value,
        'entryBy': entryBy,
      });
      // categories wise data
      await fireStore
          .collection('allHistory')
          .doc()
          .collection(collectionName)
          .doc()
          .set({
            'itemType':
                list[itemSelectIndex.value],
            'itemName': name,
            'serialNo': serial,
            'itemCost': cost,
            'itemQuantity': quantity,
            'entryDate': selectedDate.value,
            'entryBy': entryBy,
          });

      SuccessSnackbar.show(
        title: success,
        message: itemAddedSuccessfully,
      );

      nameC.clear();
      serialNoC.clear();
      costC.clear();
      quantityC.clear();
      selectedItem.value = '';
      selectedDate.value = '';
      itemSelectIndex.value = -1;
    } catch (e) {
      ErrorSnackbar.show(title: failed, message: "Failed to add item: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onTap() {
    print("Selected Index: ${itemSelectIndex.value}");
  }
}*/

/*
import 'package:ase/constant/cont_text.dart';
import 'package:ase/widgets/custom_snakBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemController extends GetxController {
  final auth = FirebaseAuth.instance.currentUser!.uid;
  final fireStore = FirebaseFirestore.instance;
  TextEditingController nameC = TextEditingController();
  TextEditingController serialNoC = TextEditingController();
  TextEditingController costC = TextEditingController();
  TextEditingController quantityC = TextEditingController();
  RxString selectedItem = ''.obs;
  RxBool selectedTimeOn = true.obs;
  RxBool isLoading = true.obs;
  RxString? selectedDate = RxString('');
  RxInt? itemSelectIndex;
  List<String> list = ['Switch', 'Router', 'FireWall', 'Server', 'Other'];

  // date picker
  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedDate!.value = "${picked.year}-${picked.month}-${picked.day}";
      selectedTimeOn.value != false;
    }
  }

  Future<void> updateAllHistory() async {
    isLoading.value = true;
    final name = nameC.text.trim();
    final serial = serialNoC.text.trim();
    final cost = costC.text.trim();
    final quantity = quantityC.text.trim();

    DocumentSnapshot userDoc =
        await fireStore.collection('users').doc(auth).get();
    String entryBy =
        userDoc.exists ? userDoc['name'] ?? 'Unknown User' : 'Unknown User';

    if (selectedItem.value.isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseSelectItem);
      isLoading.value = false;
    } else if (nameC.text.isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseEnterNameOfItem);
      isLoading.value = false;
    } else if (serialNoC.text.isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseEnterSerialNo);
      isLoading.value = false;
    } else if (quantityC.text.isEmpty) {
      ErrorSnackbar.show(title: failed, message: pleaseEnterQuantityOfItem);
      isLoading.value = false;
    } else if (itemSelectIndex?.value == null) {
      ErrorSnackbar.show(title: failed, message: pleaseSelectItemType);
    } else {
      switch (itemSelectIndex!.value) {
        case 0: // Switch
          fireStore
              .collection('allHistory')
              .doc()
              .collection('switches')
              .doc()
              .set({
                'itemType': 'Switch',
                'itemName': name,
                'serialNo': serial,
                'itemCost': cost,
                'itemQuantity': quantity,
                'entryDate': selectedDate ?? '',
                'entryBy': entryBy,
              });
          break;

        case 1: // Router
          fireStore
              .collection('allHistory')
              .doc()
              .collection('routers')
              .doc()
              .set({
                'itemType': 'Router',
                'itemName': name,
                'serialNo': serial,
                'itemCost': cost,
                'itemQuantity': quantity,
                'entryDate': selectedDate ?? '',
                'entryBy': entryBy,
              });
          break;
        case 2: // FireWall
          fireStore
              .collection('allHistory')
              .doc()
              .collection('firewalls')
              .doc()
              .set({
                'itemType': 'firewall',
                'itemName': name,
                'serialNo': serial,
                'itemCost': cost,
                'itemQuantity': quantity,
                'entryDate': selectedDate ?? '',
                'entryBy': entryBy,
              });
          break;
        case 3: // Server
          fireStore
              .collection('allHistory')
              .doc()
              .collection('servers')
              .doc()
              .set({
                'itemType': 'server',
                'itemName': name,
                'serialNo': serial,
                'itemCost': cost,
                'itemQuantity': quantity,
                'entryDate': selectedDate ?? '',
                'entryBy': entryBy,
              });
          break;
        case 4: // Other
          fireStore
              .collection('allHistory')
              .doc()
              .collection('others')
              .doc()
              .set({
                'itemType': 'other',
                'itemName': name,
                'serialNo': serial,
                'itemCost': cost,
                'itemQuantity': quantity,
                'entryDate': selectedDate ?? '',
                'entryBy': entryBy,
              });
          break;
        default:
          ErrorSnackbar.show(title: failed, message: "Invalid item selected");
          isLoading.value = false;
          return;
      }
    }
  }

  void onTap() {
    print(itemSelectIndex!.value.toString());
    print('hhh');
  }
}
*/
