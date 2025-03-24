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
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLandscape = constraints.maxWidth > 600;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isLandscape ? 10.w : 5.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: isLandscape ? 5.h : 8.h),

                  // Logo Image
                  Image.asset(
                    appLogo,
                    width: isLandscape ? 35.w : 80.w,
                    height: isLandscape ? 25.h : 35.h,
                    fit: BoxFit.contain,
                  ),

                  5.height,

                  // Welcome Text
                  Text(
                    welcomeBack,
                    style: kHeading2B.copyWith(
                      fontSize: isLandscape ? 20.sp : 25.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    loginIntoYourAccount,
                    style: kSmallTitle1,
                    textAlign: TextAlign.center,
                  ),

                  15.height,

                  // Form Fields
                  Column(
                    children: [
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        hint: 'Email',
                        icon: Icons.person,
                        controller: Get.put(AuthController()).emailC,
                      ),
                      10.height,
                      Obx(
                        () => CustomTextField(
                          obscureText: !Get.find<AuthController>().isTure.value,
                          keyboardType: TextInputType.text,
                          hint: password,
                          icon: Icons.lock,
                          suffixIcon:
                              Get.find<AuthController>().isTure.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                          suffixOnTap: Get.find<AuthController>().obscureOnTap,
                          controller: Get.find<AuthController>().passC,
                        ),
                      ),
                      10.height,

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: Text(forgotPassword, style: kSmallTitle1),
                          onTap: () => Get.to(() => const ForgotView()),
                        ),
                      ),
                      15.height,

                      // Login Button
                      Obx(() {
                        return CustomButton(
                          title:
                              Get.find<AuthController>().isLoading.value
                                  ? loading
                                  : login,
                          onTap: () {
                            final authController = Get.find<AuthController>();
                            if (authController.emailC.text.isEmpty ||
                                authController.passC.text.isEmpty) {
                              ErrorSnackbar.show(
                                title: failed,
                                message: enterValidCredential,
                              );
                            } else {
                              authController.login();
                            }
                          },
                        );
                      }),

                      20.height,

                      // Sign-Up Option
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?', style: kSmallTitle1),
                          2.width,
                          Flexible(
                            child: InkWell(
                              child: Text(
                                signUp,
                                style: kSmallTitle1.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () => Get.to(() => const SignupView()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
