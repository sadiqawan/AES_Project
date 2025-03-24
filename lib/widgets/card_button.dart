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
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLandscape = constraints.maxWidth > 600;

        return InkWell(
          onTap: onTap,
          child: Container(
            height: isLandscape ? 20.h : 25.h,
            width: isLandscape ? 40.w : 45.w,
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.sp),
              color: kSecondaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: kBlack, size: isLandscape ? 25.sp : 30.sp),
                5.height,
                Text(
                  title,
                  style: kSubTitle2B.copyWith(fontSize: isLandscape ? 14.sp : 16.sp),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
