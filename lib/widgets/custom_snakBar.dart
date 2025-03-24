import 'package:ase/constant/cont_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ErrorSnackbar {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.red,
    SnackPosition position = SnackPosition.TOP,
    IconData icon = Icons.running_with_errors,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor.withOpacity(0.3),
      colorText: kBlack,
      icon: Icon(icon, color: kBlack, size: 25.sp),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }
}

class SuccessSnackbar {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.green,
    SnackPosition position = SnackPosition.TOP,
    IconData icon = Icons.check_box,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor.withOpacity(0.3),
      colorText: kBlack,
      icon: Icon(icon, color: kBlack, size: 25.sp),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }
}
