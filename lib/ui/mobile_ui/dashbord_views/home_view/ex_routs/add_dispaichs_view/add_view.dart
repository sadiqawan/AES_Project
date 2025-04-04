import 'package:ase/constant/cont_text.dart';
import 'package:ase/extensions/size_box.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/home_view/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../constant/const_style.dart';
import '../../../../../../constant/cont_colors.dart';
import '../../../../../../widgets/costum_button.dart';
import '../../../../../../widgets/custom_textfield.dart';

class AddView extends StatefulWidget {
  final String type;
  final String name;
  final String model;
  final String sNo;
  final String quantity;
  final String cost;
  final String id;

  const AddView({
    super.key,
    required this.name,
    required this.model,
    required this.quantity,
    required this.cost,
    required this.sNo,
    required this.type,
    required this.id,
  });

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    HomeScreenController controller = Get.put(HomeScreenController());

    final upCost = int.tryParse(widget.cost);
    final upQuan = int.tryParse(widget.quantity);
    return Scaffold(
      appBar: AppBar(title: const Text('Update Stock')),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.height,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.sp),
                    boxShadow: [
                      BoxShadow(
                        color: kSecondaryColor,
                        blurRadius: 10,
                        offset: Offset(1, 7),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Type', widget.type),
                      5.height,
                      _buildInfoRow('Name', widget.name),
                      5.height,
                      _buildInfoRow('S.No', widget.sNo),
                      5.height,
                      _buildInfoRow('Model', widget.model),
                      5.height,
                      _buildInfoRow('Current Quantity', widget.quantity),
                      5.height,
                      _buildInfoRow('Current Cost', widget.cost),
                    ],
                  ),
                ),
                15.height,
                _buildInfoRow('Alert', 'Enter correct type of Item'),
                5.height,


                // Dropdown
                DropdownButtonFormField<String>(
                  dropdownColor: kSecondaryColor,
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  hint: Text(
                    selectItem,
                    style: kSmallTitle1.copyWith(fontSize: 14.sp),
                  ),
                  value:
                      controller.selectedItem.value.isEmpty
                          ? null
                          : controller.selectedItem.value,
                  items:
                      controller.list.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      controller.selectedItem.value = value;
                      controller.itemSelectIndex!.value = controller.list
                          .indexOf(value);
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: kSecondaryColor,
                    filled: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  ),
                ),


                10.height,
                _inPut(
                  enterQuantity,
                  quantity,
                  controller.quantityC,
                  Icons.confirmation_number_outlined,
                  true,
                ),

                10.height,
                _inPut(
                  enterCost,
                  cost,
                  controller.costC,
                  Icons.monetization_on_rounded,
                  true,
                ),

                10.height,
                _inPut(
                  enterCondition,
                  condition,
                  controller.conditionC,
                  Icons.new_releases_outlined,
                  false,
                ),
                10.height,
                Text(
                  dateOfEntry,
                  style: kSmallTitle1.copyWith(fontSize: 17.sp),
                ),
                5.height,
                CustomButton(
                  title:
                      controller.selectedDate.value.isNotEmpty
                          ? controller.selectedDate.value
                          : onTapSelectedDate,
                  onTap: () => controller.pickDate(context),
                  btnStyle: kSmallTitle1.copyWith(fontSize: 16.sp),
                ),
                30.height,
                CustomButton(
                  title: controller.isLoading.value ? submitting : submit,
                  onTap: () {
                    controller.updateAvailableStock(
                      context,
                      widget.id,
                      upCost!,
                      upQuan!,
                      widget.name,
                      widget.sNo,
                      widget.model,
                    );
                  },
                ),
                30.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _inPut(
  String title,
  String hint,
  TextEditingController controller,
  IconData icon,
  bool keyBordTypeNumber,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: kSmallTitle1.copyWith(fontSize: 17.sp)),
      CustomTextField(
        hint: hint,
        controller: controller,
        icon: icon,
        keyboardType:
            keyBordTypeNumber ? TextInputType.number : TextInputType.text,
      ),
    ],
  );
}

Widget _buildInfoRow(String title, String value) {
  return RichText(
    text: TextSpan(
      text: '$title:   ',
      style: kSubTitle1?.copyWith(fontWeight: FontWeight.bold),
      children: [TextSpan(text: value, style: kSubTitle1.copyWith(fontSize: 16.sp))],
    ),
  );
}
