import 'package:ase/extensions/size_box.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constant/const_style.dart';
import '../constant/cont_colors.dart';

class UpdateCard extends StatelessWidget {
  final String title;
  final String message;
  final String userName;
  final String userEmail;
  final DateTime timestamp;

  const UpdateCard({
    Key? key,
    required this.title,
    required this.message,
    required this.userName,
    required this.userEmail,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: EdgeInsets.only(bottom: 2.h),
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title[0].toUpperCase() + title.substring(1),
              style: kSubTitle2B.copyWith(color: kPrimaryColor),
            ),
            5.height,
            Text(message, style: kSubTitle1.copyWith(fontSize: 16.sp)),
            2.height,
            Divider(color: Colors.grey[300]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Updates By ${userEmail}',
                  style: kSmallTitle1.copyWith(fontSize: 12.sp),
                ),
                Text(
                  "${timestamp.day}/${timestamp.month}/${timestamp.year} - ${timestamp.hour}:${timestamp.minute}",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}