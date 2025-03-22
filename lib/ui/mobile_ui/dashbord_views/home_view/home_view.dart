import 'package:ase/extensions/size_box.dart';
import 'package:ase/widgets/card_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      leading: userImage(),  // Keep just the user image in leading
      title: Text(
        "Welcome To 👋 AES",
        style: kSubTitle2B,
      ),
    ),

    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [


          20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardButton(
                onTap: () {},
                icon: Icons.access_alarm,
                title: 'Available Stock',
              ),
              10.width,
              CardButton(
                onTap: () {},
                icon: Icons.list_alt_rounded,
                title: 'Stock Categories',
              ),
            ],
          ),
          10.height,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardButton(
                onTap: () {},
                icon: Icons.download,
                title: 'Stock Summary',
              ),
              10.width,
              CardButton(
                onTap: () {},
                icon: Icons.add,
                title: 'Add New  Stock',
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

