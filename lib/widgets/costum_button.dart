
import 'package:ase/constant/const_style.dart';
import 'package:ase/constant/cont_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final VoidCallback onTap;
  final Color? color;
  final TextStyle? btnStyle;

  const CustomButton(
      {super.key,
        required this.title,
        this.width,
        this.height,
        required this.onTap,
        this.color,
        this.btnStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 8.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color ?? kSecondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
                title,
                style: btnStyle ?? kSubTitle2B
            )),
      ),
    );
  }
}