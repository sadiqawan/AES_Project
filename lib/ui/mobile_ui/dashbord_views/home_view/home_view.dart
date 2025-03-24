import 'package:ase/constant/assets.dart';
import 'package:ase/constant/cont_text.dart';
import 'package:ase/extensions/size_box.dart';
import 'package:ase/widgets/card_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../constant/const_style.dart';
import '../../../../widgets/userImageGet.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: userImage(),
      title: Text(welcome, style: kSubTitle2B),
    ),

    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                appLogo,
                height: 20.h,
                width: 30.w,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardButton(
                  onTap: () {},
                  icon: Icons.access_alarm,
                  title: stockHistory,
                ),
                10.width,
                CardButton(
                  onTap: () {},
                  icon: Icons.list_alt_rounded,
                  title: stockAvailable,
                ),
              ],
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardButton(
                  onTap: () {
                  },
                  icon: Icons.download,
                  title: stockSummary,
                ),
                10.width,
                CardButton(
                  onTap: () {},
                  icon: Icons.recycling,
                  title: stockDispatch,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
