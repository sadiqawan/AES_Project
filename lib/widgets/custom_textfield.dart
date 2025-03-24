import 'package:ase/constant/const_style.dart';
import 'package:ase/constant/cont_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final ValueChanged<String>? onSubmit;
  final VoidCallback? suffixOnTap ;

  const CustomTextField({
    required this.hint,
    required this.controller,
    required this.icon,
    super.key,
    this.keyboardType,
    this.obscureText,
    this.onSubmit,
    this.suffixIcon,
    this.suffixOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 9.h,
      alignment: Alignment.center,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onSubmitted: onSubmit,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        controller: controller,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon, size: 20.sp),
          suffixIcon: IconButton(onPressed: suffixOnTap, icon: Icon(suffixIcon)),
          prefixIconConstraints: BoxConstraints(
            minWidth: 15.w,
            minHeight: 15.w,
          ),
          hintStyle: kSmallTitle1.copyWith(color: kBlack.withOpacity(.4)),
          contentPadding: EdgeInsets.symmetric(vertical: 2.h),
        ),
      ),
    );
  }
}
