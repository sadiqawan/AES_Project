import 'package:ase/constant/cont_text.dart';
import 'package:ase/extensions/size_box.dart';
import 'package:ase/ui/mobile_ui/auth_views/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/const_style.dart';
import '../../../widgets/costum_button.dart';
import '../../../widgets/custom_snakBar.dart';
import '../../../widgets/custom_textfield.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  AuthController authController = Get.put(AuthController());
  return Scaffold(
    appBar: AppBar(),
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            20.height,
            Text('Forget Password', style: kHeading2B.copyWith(fontSize: 25.sp)),
            10.height,
            Text(enterYourValidEmail, style: kSmallTitle1),
            100.height,

            CustomTextField(
              keyboardType: TextInputType.emailAddress,
              hint: email,
              icon: Icons.person,
              controller: authController.emailC,
            ),
            40.height,


            Obx(() {
              return CustomButton(
                title: authController.isLoading.value ? loading : send,
                onTap: () {
                  if (authController.emailC.text.isEmpty ||
                      authController.passC.text.isEmpty) {
                    ErrorSnackbar.show(
                      title: 'Failed',
                      message: 'Error: Enter valid Credentials',
                    );
                  } else {
                    // authController.login();
                  }
                },
              );
            }),

          ],
        ),
      ),
    ),
  );
}
