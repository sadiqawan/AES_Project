import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:ase/constant/cont_colors.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/home_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/item_listing_view/add_item_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/profile_view/profile_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/updates_view/updates_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_controller/app_controller.dart';

class NavigationView extends StatelessWidget {
  NavigationView({super.key});

  final AppController appController = Get.put(AppController()); // Moved inside the class
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

  final List<Widget> bottomBarPages = [
    HomeView(),
    AddItemView(),
    UpdatesView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: appController.pageController,
        physics: const BouncingScrollPhysics(),
        children: bottomBarPages,
        onPageChanged: (index) {
          appController.selectedIndex.value = index;
          _controller.jumpTo(index); // Synchronize Bottom Navigation Bar
        },
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: kSecondaryColor,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 5,
        kBottomRadius: 28.0,
        notchColor: kSecondaryColor,
        removeMargins: false,
        bottomBarWidth: 500,
        showShadow: true,
        durationInMilliSeconds: 300,
        itemLabelStyle: const TextStyle(fontSize: 10),
        elevation: 2,
        kIconSize: 24.0,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(Icons.home_filled, color: kBlack),
            activeItem: Obx(() => Icon(Icons.home_filled, color: appController.selectedIndex.value == 0 ? kWhite : kBlack)),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.add_business_outlined, color: kBlack),
            activeItem: Obx(() => Icon(Icons.add_business_outlined, color: appController.selectedIndex.value == 1 ? kWhite : kBlack)),
            itemLabel: 'AddItem',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.add_alert_sharp, color: kBlack),
            activeItem: Obx(() => Icon(Icons.add_alert_sharp, color: appController.selectedIndex.value == 2 ? kWhite : kBlack)),
            itemLabel: 'Updates',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person, color: kBlack),
            activeItem: Obx(() => Icon(Icons.person, color: appController.selectedIndex.value == 3 ? kWhite : kBlack)),
            itemLabel: 'Profile',
          ),
        ],
        onTap: (index) {
          appController.selectedIndex.value = index;
          appController.pageController.jumpToPage(index);
        },
      ),
    );
  }
}
