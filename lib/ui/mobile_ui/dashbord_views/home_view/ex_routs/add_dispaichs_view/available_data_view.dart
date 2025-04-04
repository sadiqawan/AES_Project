import 'package:ase/extensions/size_box.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/add_dispaichs_view/add_dispatch_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/add_dispaichs_view/update_firewalls_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/add_dispaichs_view/update_others_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/add_dispaichs_view/update_router_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/add_dispaichs_view/update_servers_view.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/add_dispaichs_view/update_switchs_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../constant/const_style.dart';
import '../../../../../../constant/cont_colors.dart';

class AvailableDataView extends StatefulWidget {
  const AvailableDataView({super.key});

  @override
  State<AvailableDataView> createState() => _AvailableDataViewState();
}

class _AvailableDataViewState extends State<AvailableDataView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add || Dispatch')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            10.height,
            _listTile(
              'All Data',
              'Available Stock...',
              Icons.history,
                  () {
                Get.to(() =>AddDispatchView());
              },
            ),
            10.height,
            _listTile(
              'Switches Data',
              'Available Switches...',
              Icons.swap_horizontal_circle_outlined,
                  () {
                Get.to(() => UpdateSwitchesView());
              },
            ),
            10.height,
            _listTile(
              'Routers Data',
              'Available Routers...',
              Icons.router,
                  () {
                Get.to(() => UpdateRouterView());
              },
            ),
            10.height,
            _listTile(
              'Servers  Data',
              'Available Servers...',
              Icons.dns,
                  () {
                Get.to(() => UpdateServersView());
              },
            ),
            10.height,
            _listTile(
              'Firewalls Data',
              'Available Firewalls...',
              Icons.local_fire_department_outlined,
                  () {
                Get.to(() => UpdateFirewallsView());
              },
            ),
            10.height,
            _listTile(
              'Others Data',
              'Available Passive items...',
              Icons.category,
                  () {
                Get.to(() => UpdateOthersView());
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

