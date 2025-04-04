import 'package:ase/extensions/size_box.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/profile_view/profile_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../../constant/const_style.dart';
import '../../../../constant/cont_colors.dart';
import '../../../../widgets/costum_button.dart';
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  ProfileViewController profileViewController = Get.put(
    ProfileViewController(),
  );
  final format = DateFormat('MMMM dd yyyy');
  return Scaffold(
    appBar: AppBar(),
    body: SingleChildScrollView(
      child: Column(
        children: [
          5.height,
          Text('PROFILE', style: kHeading2B),
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: profileViewController.getUserDataStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(

                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo_01.png'),
                            fit: BoxFit.fill,
                          ),
                          border: Border.all(color: kBlack, width: 5),
                        ),
                        height: 30.h,
                        width: 40.w,
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          backgroundColor: kWhite,
                          isScrollControlled: true, // Allows the bottom sheet to expand
                          Container(
                            padding: EdgeInsets.all(2.w),
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxHeight: 50.h,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'UpdateYourPic',
                                  style: kHeading2B.copyWith(fontSize: 12.sp),
                                ),
                                2.height,
                                Divider(thickness: 1, color: Colors.grey.shade300),
                                3.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      child: CustomButton(
                                        title: 'Select Camera',
                                        btnStyle: kSmallTitle1.copyWith(fontSize: 12.sp),

                                        onTap: () {
                                          profileViewController.pickImageFrom(ImageSource.camera);
                                          Get.back();
                                        },
                                      ),
                                    ),
                                    1.width,
                                    Flexible(
                                      child: CustomButton(
                                        title: 'Select Gallery',
                                        btnStyle: kSmallTitle1.copyWith(fontSize: 12.sp),
                                        onTap: () {
                                          profileViewController.pickImageFrom(ImageSource.gallery);
                                          Get.back();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Update Pic', style: kSubTitle2B),
                          const Icon(Icons.edit_outlined),
                        ],
                      ),
                    ),

                    _widget(Icons.person_outline, 'Name'),
                    _widget(Icons.email_outlined, 'Email'),
                    _widget(Icons.watch_later_outlined, 'Time'),
                  ],
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  !snapshot.data!.exists) {
                return const Center(child: Text('No data available'));
              }
      
              var userData = snapshot.data!.data();
              DateTime? time =
                  userData?['time'] != null
                      ? (userData?['time'] as Timestamp).toDate()
                      : null;
      
              return Column(
                children: [
                  userData!['picture'] == null
                      ? Center(
                    child: Container(
                      decoration: BoxDecoration(

                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo_01.png'),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(color: kBlack, width: 5),
                      ),
                      height: 30.h,
                      width: 40.w,
                    ),
                  )
                      : Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: kBlack,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(userData['picture']),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(color: kBlack, width: 5),
                          ),
                          height: 30.h,
                          width: 40.w,
                        ),
                      ),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        backgroundColor: kWhite,
                        Padding(
                          padding:  EdgeInsets.all( 4.w),
                          child: SizedBox(
                            height: 30.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Update Your Pic', style: kHeading2B.copyWith(fontSize: 24.sp)
                                ),
                              Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      child: CustomButton(
                                        title: 'Select Camera',
                                        btnStyle: kSmallTitle1,
                                        onTap: () {
                                          profileViewController.pickImageFrom(
                                            ImageSource.camera,
                                          );
                                          Get.back();
                                        },
                                      ),
                                    ),
                                  5.width,
                                    Flexible(
                                      child: CustomButton(
                                        title: 'Select Gallery',
                                        btnStyle: kSmallTitle1,
                                        onTap: () {
                                          profileViewController.pickImageFrom(
                                            ImageSource.gallery,
                                          );
                                          Get.back();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Update Pic', style: kSubTitle2B),
                        const Icon(Icons.edit_outlined),
                      ],
                    ),
                  ),
                  10.height,
                  _widget(Icons.person_outline, userData['name'] ?? 'No Name'),
                  _widget(Icons.email_outlined, userData['email'] ?? 'No Email'),
                  _widget(
                    Icons.watch_later_outlined,
                    time != null ? format.format(time) : 'No Time',
                  ),
                ],
              );
            },
          ),
          InkWell(
            onTap: () {
              Get.dialog(
                AlertDialog(
                  backgroundColor: Colors.black,
                  // Set the background color of the dialog
                  title: Text(
                    'Logout Confirmation',
                    style: kSubTitle1.copyWith(color: kWhite),
                  ),
                  content: Text(
                    'Are you sure you want to log out?',
                    style: kSmallTitle1.copyWith(color: kWhite),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'Cancel',
                        style: kSmallTitle1.copyWith(color: kWhite),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        profileViewController.logout();
                      },
                      child: Text(
                        'Logout',
                        style: kSmallTitle1.copyWith(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: _widget(Icons.login_outlined, 'Logout'),
          ),
          80.height,
        ],
      ),
    ),
  );
}

Widget _widget(IconData icon, String value) {
  return ListTile(
    leading: Icon(icon, size: 40),
    title: Text(value, style: kSubTitle2B),
  );
}
