import 'dart:io';
import 'package:ase/ui/mobile_ui/auth_views/login_view.dart';
import 'package:ase/widgets/custom_snakBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewController extends GetxController {
  File? image;
  String imageUrl = '';

  // Stream to get user data
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDataStream() {
    String uId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uId).snapshots();
  }

  // Function to pick an image from the source and upload it
  Future<void> pickImageFrom(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        final image = File(pickedFile.path);
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final storageRef = FirebaseStorage.instance.ref().child(
            '${user.uid}.jpg',
          );
          await storageRef.putFile(image);
          final imageUrl = await storageRef.getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'picture': imageUrl});

          SuccessSnackbar.show(
            title: "Success",
            message: "Image updated successfully",
          );
        } else {
          ErrorSnackbar.show(
            title: 'Error',
            message: 'User is not authenticated',
          );
        }
      }
    } on FirebaseException catch (e) {
      if (e.code == 'unauthorized') {
        ErrorSnackbar.show(
          title: 'Error',
          message: 'You are not authorized to perform this action',
        );
      } else {
        ErrorSnackbar.show(title: 'Error', message: 'Error: ${e.message}');
      }
      print("Firebase Exception: $e");
    } catch (e) {
      ErrorSnackbar.show(title: 'Error', message: 'Error: ${e.toString()}');
      print("Error picking image: $e");
    }
  }

  Future<void> logout() async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signOut();
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setBool('is_login', false);
      Get.offAll(const LoginView());
      SuccessSnackbar.show(title: "Success", message: 'Successfully logout!');
    } catch (e) {
      ErrorSnackbar.show(title: "Failed", message: 'Failed!${e.toString()}');
    }
  }
}
