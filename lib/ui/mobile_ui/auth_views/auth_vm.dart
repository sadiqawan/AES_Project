import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final nameC = TextEditingController();
  final forgetC = TextEditingController();
  var isLoading = false.obs;

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    nameC.dispose();
    super.dispose();
  }


}