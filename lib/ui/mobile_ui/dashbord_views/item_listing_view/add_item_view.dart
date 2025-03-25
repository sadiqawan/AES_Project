import 'package:ase/constant/const_style.dart';
import 'package:ase/constant/cont_colors.dart';
import 'package:ase/extensions/size_box.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/item_listing_view/add_item_vm.dart';
import 'package:ase/widgets/costum_button.dart';
import 'package:ase/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/cont_text.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  AddItemController controller = Get.put(AddItemController());
  final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

  return Scaffold(
    appBar: AppBar(centerTitle: true, title: const Text(listItem)),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SingleChildScrollView(
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.height,
              Center(
                child: Image.asset(
                  personLogo,
                  height: isLandscape ? 30.h : 10.h,
                  width: isLandscape ? 15.w : 20.w,
                  fit: BoxFit.cover,
                ),
              ),
              10.height,
              Text(
                selectItemType,
                style: kSmallTitle1.copyWith(fontSize: 17.sp),
              ),
              5.height,

              // Dropdown
              DropdownButtonFormField<String>(
                dropdownColor: kSecondaryColor,
                padding: EdgeInsets.symmetric(vertical: 3.h),
                hint: Text(
                  selectItem,
                  style: kSmallTitle1.copyWith(fontSize: 14.sp),
                ),
                value: controller.selectedItem.value.isEmpty ? null : controller.selectedItem.value,
                items: controller.list.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    controller.selectedItem.value = value;
                    controller.itemSelectIndex!.value = controller.list.indexOf(value);
                  }
                },
                decoration: InputDecoration(
                  fillColor: kSecondaryColor,
                  filled: true,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                ),
              ),
              8.height,

              // Responsive Form Fields
              isLandscape
                  ? Row(
                children: [
                  Expanded(child: _inPut(enterItemName, name, controller.nameC, Icons.insert_invitation_outlined, false)),
                  5.width,
                  Expanded(child: _inPut(enterSerialNo, sNo, controller.serialNoC, Icons.segment_rounded, false)),
                ],
              )
                  : Column(
                children: [
                  _inPut(enterItemName, name, controller.nameC, Icons.insert_invitation_outlined, false),
                  10.height,
                  _inPut(enterSerialNo, sNo, controller.serialNoC, Icons.segment_rounded, false),
                ],
              ),
              10.height,
              _inPut(modelNo, model, controller.modelC, Icons.segment_rounded, false),
              10.height,
              _inPut(enterCondition, condition, controller.conditionC, Icons.new_releases_outlined, false),
              10.height,
              _inPut(enterCost, cost, controller.costC, Icons.monetization_on_rounded, true),
              10.height,
              _inPut(enterQuantity, quantity, controller.quantityC, Icons.confirmation_number_outlined, true),
              10.height,
              Text(dateOfEntry, style: kSmallTitle1.copyWith(fontSize: 17.sp)),
              5.height,
              CustomButton(
                title: controller.selectedDate.value.isNotEmpty ? controller.selectedDate.value : onTapSelectedDate,
                onTap: () => controller.pickDate(context),
                btnStyle: kSmallTitle1.copyWith(fontSize: 16.sp),
              ),
              30.height,
              CustomButton(
                title: controller.isLoading.value ? submitting : submit,
                onTap: () {
                  controller.updateAllHistory();
                },
              ),
              120.height,
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _inPut(String title, String hint, TextEditingController controller, IconData icon, bool keyBordTypeNumber) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: kSmallTitle1.copyWith(fontSize: 17.sp)),
      CustomTextField(
        hint: hint,
        controller: controller,
        icon: icon,
        keyboardType: keyBordTypeNumber ? TextInputType.number : TextInputType.text,
      ),
    ],
  );
}