import 'package:ase/extensions/size_box.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constant/const_style.dart';
import '../constant/cont_colors.dart';

class CardButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;

  const CardButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 25.h,
          width: 45.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.sp),
            color: kSecondaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: kBlack, size: 30.sp),
              5.height,
              Text(
                title,
                style: kSubTitle2B.copyWith(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
