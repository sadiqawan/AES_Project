import 'package:ase/constant/const_style.dart';
import 'package:ase/constant/cont_colors.dart';
import 'package:ase/extensions/size_box.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/stock_history_routs/all_history.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/stock_history_routs/firewall_history.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/stock_history_routs/others_history.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/stock_history_routs/routers_history.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/stock_history_routs/servers_history.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/ex_routs/stock_history_routs/switches_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class StockHistoryEx1 extends StatefulWidget {
  const StockHistoryEx1({super.key});

  @override
  State<StockHistoryEx1> createState() => _StockHistoryEx1State();
}

class _StockHistoryEx1State extends State<StockHistoryEx1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            10.height,
            _listTile(
              'All History',
              'History of all data...',
              Icons.history,
              () {
                Get.to(() => AllHistoryView());
              },
            ),
            10.height,
            _listTile(
              'Switches History',
              'History of all Switches...',
              Icons.swap_horizontal_circle_outlined,
              () {
                Get.to(() => SwitchesHistoryView());
              },
            ),
            10.height,
            _listTile(
              'Routers History',
              'History of all Routers...',
              Icons.router,
              () {
                Get.to(() => RoutersHistoryView());
              },
            ),
            10.height,
            _listTile(
              'Servers History',
              'History of all Servers...',
              Icons.dns,
              () {
                Get.to(() => ServersHistoryView());
              },
            ),
            10.height,
            _listTile(
              'Firewalls History',
              'History of all Firewalls...',
              Icons.local_fire_department_outlined,
              () {
                Get.to(() => FirewallHistoryView());
              },
            ),
            10.height,
            _listTile(
              'Others History',
              'History of all Passive items...',
              Icons.category,
              () {
                Get.to(() => OthersHistoryView());
              },
            ),
            10.height,
          ],
        ),
      ),
    );
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
}
