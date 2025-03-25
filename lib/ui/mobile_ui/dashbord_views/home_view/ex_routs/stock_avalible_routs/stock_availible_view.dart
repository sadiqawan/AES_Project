import 'package:ase/extensions/size_box.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/stock_avalible_routs/available_firewall_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/stock_avalible_routs/available_routers_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/stock_avalible_routs/available_servers_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/stock_avalible_routs/available_switches_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/stock_avalible_routs/othes_availability_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../constant/const_style.dart';
import '../../../../../../constant/cont_colors.dart';
import 'all_availability_view.dart';

class StockAvailableView extends StatefulWidget {
  const StockAvailableView({super.key});

  @override
  State<StockAvailableView> createState() => _StockAvailableViewState();
}

class _StockAvailableViewState extends State<StockAvailableView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Availability')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            10.height,
            _listTile(
              'Available Stock',
              'Available Stock data...',
              Icons.history,
                  () {
                Get.to(() => AllAvailabilityView());
              },
            ),
            10.height,
            _listTile(
              'Available Switches',
              'Availability of all Switches...',
              Icons.swap_horizontal_circle_outlined,
                  () {
                Get.to(() => AvailableSwitchesView());
              },
            ),
            10.height,
            _listTile(
              'Available Routers',
              'Availability of all Routers...',
              Icons.router,
                  () {
                Get.to(() => AvailableRoutersView());
              },
            ),
            10.height,
            _listTile(
              'Available Servers',
              'Availability of all Servers...',
              Icons.dns,
                  () {
                Get.to(() => AvailableServersView());
              },
            ),
            10.height,
            _listTile(
              'Available Firewalls',
              'Availability of all Firewalls...',
              Icons.local_fire_department_outlined,
                  () {
                Get.to(() => AvailableFirewallView());
              },
            ),
            10.height,
            _listTile(
              'Others Availability',
              'Availability of all Passive items...',
              Icons.category,
                  () {
                Get.to(() => OthersAvailabilityView());
              },
            ),
            10.height,
          ],
        ),
      ),
    );
  }
}

Widget _listTile(
    String title,
    String subTitle,
    IconData icon,
    VoidCallback onTap,
    ) {
  return Card(
    color: kSecondaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      onTap: onTap,
      title: Text(title, style: kSubTitle1),
      subtitle: Text(subTitle),
      leading: Icon(icon, size: 25.sp, color: kWhite),
      trailing: Icon(Icons.arrow_forward_ios, color: kBlack),
    ),
  );
}



