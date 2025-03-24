import 'package:ase/constant/cont_colors.dart';
import 'package:ase/extensions/size_box.dart';
import 'package:ase/ui/mobile_ui/auth_views/auth_vm.dart';
import 'package:ase/ui/mobile_ui/auth_views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../constant/const_style.dart';
import '../../../constant/cont_text.dart';
import '../../../widgets/costum_button.dart';
import '../../../widgets/custom_snakBar.dart';
import '../../../widgets/custom_textfield.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  AuthController authController = Get.put(AuthController());

  return Scaffold(
    appBar: AppBar(backgroundColor: kSecondaryColor),
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            5.h.height,
            Text(register, style: kHeading2B),
            2.h.height,
            Text(createNewAccount, style: kSmallTitle1),
            6.h.height,

            Column(
              children: [
                _enterFieldText(enterYourName),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  hint: fullName,
                  icon: Icons.person,
                  controller: authController.nameC,
                ),
                2.h.height,
                _enterFieldText(enterYourEmail),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  hint: email,
                  icon: Icons.email,
                  controller: authController.emailC,
                ),
                2.h.height,
                _enterFieldText(enterYourPassword),
                Obx(() => CustomTextField(
                  obscureText: !authController.isTure.value,
                  keyboardType: TextInputType.text,
                  hint: password,
                  icon: Icons.lock,
                  suffixIcon: authController.isTure.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  suffixOnTap: authController.obscureOnTap,
                  controller: authController.passC,
                )),
                3.h.height,

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(wordSpacing: 1.5.sp),
                    children: [
                      TextSpan(
                        text: 'By Signing you agree to our ',
                        style: kSmallTitle1.copyWith(fontSize: 14.sp),
                      ),
                      TextSpan(
                        text: 'Terms of Use ',
                        style: kSmallTitle1.copyWith(
                          fontSize: 14.sp,
                          color: kSecondaryColor,
                        ),
                      ),
                      TextSpan(
                        text: 'and ',
                        style: kSmallTitle1.copyWith(fontSize: 14.sp),
                      ),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: kSmallTitle1.copyWith(
                          fontSize: 14.sp,
                          color: kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                4.h.height,

                Obx(() {
                  return CustomButton(
                    title: authController.isLoading.value ? loading : signUp,
                    onTap: () {
                      if (authController.emailC.text.isEmpty ||
                          authController.passC.text.isEmpty) {
                        ErrorSnackbar.show(
                          title: failed,
                          message: enterValidCredential,
                        );
                      } else {
                        authController.signUp();
                      }
                    },
                  );
                }),

                2.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?', style: kSmallTitle1.copyWith(fontSize: 14.sp)),
                    2.w.width,
                    InkWell(
                      child: Text(
                        "Login here",
                        style: kSubTitle2B.copyWith(fontSize: 16.sp),
                      ),
                      onTap: () {
                        Get.offAll(() => const LoginView());
                      },
                    ),
                  ],
                ),
                2.h.height,
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _enterFieldText(String title) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: kSmallTitle1),
    ),
  );
}
