import 'package:ase/ui/mobile_ui/dashbord_views/home_view/home_view.dart';
import 'package:ase/ui/mobile_ui/splash_view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX properly
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'constant/cont_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: true,
          title: 'ASE',
          theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
            scaffoldBackgroundColor: kWhite,
            appBarTheme: AppBarTheme(backgroundColor: kSecondaryColor),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const SplashView(),
        );
      },
    );
  }
}
