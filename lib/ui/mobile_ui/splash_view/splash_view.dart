import 'dart:async';
import 'package:ase/constant/assets.dart';
import 'package:ase/constant/const_style.dart';
import 'package:ase/constant/cont_colors.dart';
import 'package:ase/constant/cont_text.dart';
import 'package:ase/extensions/size_box.dart';
import 'package:ase/ui/mobile_ui/auth_views/login_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/home_view.dart';
import 'package:fade_out_particle/fade_out_particle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    checkIfAlreadyLoggedIn();
  }

  checkIfAlreadyLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLoggedIn = pref.getBool("is_login") ?? false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 4), () {
        Get.offAll(() => isLoggedIn ? HomeView() : LoginView());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  return Scaffold(
    backgroundColor: kSecondaryColor,
    body: Column(

      children: [
        20.height,
        Center(
          child: Container(
            height: 60.h,
            width: 60.w,
            decoration: const BoxDecoration(
              color: kWhite,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(appLogo),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        10.height,

        FadeOutParticle(
          curve: Curves.bounceIn,
          duration: const Duration(seconds: 4),
          disappear: true,
          child: Text(
            appName,
            style: kHeading2B.copyWith(color: kWhite)
          ),
        ),
      ],
    ),
  );
}
