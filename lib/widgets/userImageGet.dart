import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../ui/mobile_ui/dashbord_views/profile_view/profile_vm.dart';

Widget userImage() {
  ProfileViewController controller = Get.put(ProfileViewController());
  return StreamBuilder(
      stream: controller.getUserDataStream(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            maxRadius: 25.sp,
            backgroundColor: Colors.transparent,
            backgroundImage: const AssetImage("assets/images/logo_01.png"),
          );
        }
        var userData = snapshot.data?.data();
        if (userData == null || userData['picture'] == null) {
          return CircleAvatar(
            maxRadius: 25.sp,
            backgroundColor: Colors.transparent,
            backgroundImage: const AssetImage("assets/images/logo_01.png"),
          );
        } else {
          return CircleAvatar(
            maxRadius: 25.sp,
            backgroundImage: NetworkImage(userData!['picture']),
          );
        }
      });
}