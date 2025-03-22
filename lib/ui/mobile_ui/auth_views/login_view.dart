import 'package:ase/constant/assets.dart';
import 'package:ase/constant/const_style.dart';
import 'package:ase/extensions/size_box.dart';
import 'package:ase/ui/mobile_ui/auth_views/auth_vm.dart';
import 'package:ase/ui/mobile_ui/auth_views/forgot_view.dart';
import 'package:ase/ui/mobile_ui/auth_views/signup_view.dart';
import 'package:ase/widgets/custom_snakBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../constant/cont_text.dart';
import '../../../widgets/costum_button.dart';
import '../../../widgets/custom_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  AuthController authController = Get.put(AuthController());
  return Scaffold(
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            // Image with fixed size
            Image.asset(
              appLogo,
              width: Get.width,
              height: 40.h,
              fit:
                  BoxFit
                      .contain,
            ),

            // Welcome text
            Text(
              welcomeBack,
              style: kHeading2B.copyWith(fontSize: 25.sp),
              textAlign: TextAlign.center,
            ),
            Text(
              loginIntoYourAccount,
              style: kSmallTitle1,
              textAlign: TextAlign.center,
            ),
            20.height,

            // Login form
            Column(
              children: [
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Email',
                  icon: Icons.person,
                  controller: authController.emailC,
                ),
                10.height,
                CustomTextField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  hint: 'Password',
                  icon: Icons.lock,
                  suffixIcon: Icons.remove_red_eye,
                  suffixOnTap: () {},
                  controller: authController.passC,
                ),
                10.height,
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Text(forgotPassword, style: kSmallTitle1),
                    onTap: () {
                      Get.to(() => const ForgotView());
                    },
                  ),
                ),
                15.height,
                Obx(() {
                  return CustomButton(
                    title: authController.isLoading.value ? loading : login,
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
                30.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?', style: kSmallTitle1),
                    5.width,
                    InkWell(
                      child: Text(
                        "Sign Up",
                        style: kSmallTitle1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => const SignupView());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
