import 'package:ase/constant/assets.dart';
import 'package:ase/constant/cont_text.dart';
import 'package:ase/extensions/size_box.dart';
import 'package:ase/widgets/card_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../constant/const_style.dart';
import '../../../../widgets/userImageGet.dart';
import 'ex_routs/add_dispaichs_view/add_dispatch_view.dart';
import 'ex_routs/stock_avalible_routs/stock_availible_view.dart';
import 'ex_routs/stock_history_routs/stock_history_ex_1.dart';

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
  final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

  return Scaffold(
    appBar: AppBar(
      leading: userImage(),
      title: Text(welcome, style: kSubTitle2B.copyWith(fontSize: 16.sp)),
    ),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                appLogo,
                height: isLandscape ? 40.h : 25.h,  // Adjust height in landscape mode
                width: isLandscape ? 30.w : 45.w,
                fit: BoxFit.fill,
              ),
            ),
            5.height,
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: isLandscape ? 4 : 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              shrinkWrap: true,
              children: [
                CardButton(
                  onTap: () {
                    Get.to(() => StockHistoryEx1());
                  },
                  icon: Icons.access_alarm,
                  title: stockHistory,
                ),
                CardButton(
                  onTap: () {
                    Get.to(()=>StockAvailableView());
                  },
                  icon: Icons.list_alt_rounded,
                  title: stockAvailable,
                ),
                CardButton(
                  onTap: () {},
                  icon: Icons.download,
                  title: stockSummary,
                ),
                CardButton(
                  onTap: () {
                    Get.to(()=> AddDispatchView ());
                  },
                  icon: Icons.recycling,
                  title: stockDispatch,
                ),
              ],
            ),
            100.height
          ],
        ),
      ),
    ),
  );
}
