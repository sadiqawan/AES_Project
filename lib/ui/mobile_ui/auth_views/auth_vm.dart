import 'package:ase/constant/cont_text.dart';
import 'package:ase/ui/mobile_ui/auth_views/login_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/home_view.dart';
import 'package:ase/widgets/custom_snakBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final emailC = TextEditingController();
  final passC = TextEditingController();
  final nameC = TextEditingController();
  final forgetC = TextEditingController();
  var isLoading = false.obs;
  var isTure = false.obs;

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    nameC.dispose();
    forgetC.dispose();
    super.dispose();
  }

  // obscure text function
  void obscureOnTap() {
    isTure.value = !isTure.value;
  }

  // Registration Function
  Future<void> signUp() async {
    if (nameC.text.isEmpty) {
      ErrorSnackbar.show(title: 'Error', message: 'Name cannot be empty');

      return;
    }
    if (!GetUtils.isEmail(emailC.text)) {
      ErrorSnackbar.show(title: failed, message: 'Enter a valid email');
      return;
    }
    if (passC.text.length < 6) {
      ErrorSnackbar.show(
        title: 'Error',
        message: 'Password must be at least 6 characters',
      );
      return;
    }
    isLoading.value = true;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailC.text,
        password: passC.text,
      );
      await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({
        'time': DateTime.now(),
        'name': nameC.text.trim(),
        'email': emailC.text.trim(),
        'picture': null,
      });

      SuccessSnackbar.show(
        title: 'Success',
        message: 'Account created successfully',
      );
      Get.offAll(LoginView());
    } catch (e) {
      ErrorSnackbar.show(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Login Function
  Future<void> login() async {
    if (!GetUtils.isEmail(emailC.text)) {
      ErrorSnackbar.show(title: failed, message: 'Enter a valid email');
      return;
    }
    if (passC.text.isEmpty) {
      ErrorSnackbar.show(title: failed, message: "Password cannot be empty");
      return;
    }
    isLoading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailC.text,
        password: passC.text,
      );
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setBool("is_login", true);
      SuccessSnackbar.show(title: 'Success', message: 'Logged in successfully');
      Get.offAll(HomeView());

    } catch (e) {
      ErrorSnackbar.show(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Forget Password Function
  Future<void> forgetPassword() async {
    if (!GetUtils.isEmail(forgetC.text)) {
      ErrorSnackbar.show(title: failed, message: 'Enter a valid email');
      return;
    }
    isLoading.value = true;
    try {
      await _auth.sendPasswordResetEmail(email: forgetC.text);
      SuccessSnackbar.show(
        title: 'Success',
        message: 'Password reset link sent',
      );
    } catch (e) {
      ErrorSnackbar.show(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
