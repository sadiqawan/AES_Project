import 'package:ase/constant/cont_text.dart';
import 'package:ase/widgets/custom_snakBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdateController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  bool inputValidate() {
    if (titleController.text.isEmpty) {
      ErrorSnackbar.show(title: failed, message: 'Enter Title Filed');

      return false;
    }
    if (messageController.text.isEmpty) {
      ErrorSnackbar.show(title: failed, message: 'Enter Message...');
      return false;
    }
    return true;
  }

  Future<void> updateMessage(BuildContext context) async {
    final title = titleController.text.trim();
    final message = messageController.text.trim();
    try {
      if (!inputValidate()) return;

      isLoading.value = true;
      User? user = _auth.currentUser;

      if (user == null) {
        ErrorSnackbar.show(title: failed, message: 'User not logged in!');
        return;
      }

      await _firestore.collection('updates').doc().set({
        'title': title,
        'message': message,
        'userId': user.uid,
        'userEmail': user.email ?? 'No Email',
        'timestamp': FieldValue.serverTimestamp(),
      });
      isLoading.value = false;

      SuccessSnackbar.show(
        title: success,
        message: 'Message updated successfully!',
      );
      Navigator.pop(context);
      titleController.clear();
      messageController.clear();
    } catch (e) {
      ErrorSnackbar.show(
        title: failed,
        message: 'Failed to update message: $e',
      );
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
