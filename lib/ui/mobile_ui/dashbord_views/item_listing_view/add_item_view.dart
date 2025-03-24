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
                  height: 10.h,
                  width: 20.w,
                  fit: BoxFit.cover,
                ),
              ),
              10.height,
              Text(
                selectItemType,
                style: kSmallTitle1.copyWith(fontSize: 17.sp),
              ),
              5.height,

              // Wrap Dropdown in Obx to make it reactive
              DropdownButtonFormField<String>(
                dropdownColor: kSecondaryColor,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                hint: Text(
                  selectItem,
                  style: kSmallTitle1.copyWith(fontSize: 17.sp),
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
                    controller.itemSelectIndex!.value = controller.list.indexOf(
                      value,
                    );
                  }
                },
                decoration: InputDecoration(
                  iconColor: kSecondaryColor,
                  fillColor: kSecondaryColor,
                  focusColor: kSecondaryColor,
                  hoverColor: kWhite,
                  filled: true,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                ),
              ),

              8.height,
              _inPut(
                enterItemName,
                name,
                controller.nameC,
                Icons.insert_invitation_outlined,
                false,
              ),
              10.height,
              _inPut(
                enterSerialNo,
                sNo,
                controller.serialNoC,
                Icons.segment_rounded,
                false,
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
                enterQuantity,
                quantity,
                controller.quantityC,
                Icons.confirmation_number_outlined,
                true,
              ),
              10.height,
              Text(dateOfEntry, style: kSmallTitle1.copyWith(fontSize: 17.sp)),
              5.height,

              // Date Picker Button with Correct Obx Implementation
              CustomButton(
                title:
                    controller.selectedTimeOn.value
                        ? onTapSelectedDate
                        : (controller.selectedDate!.value.isNotEmpty
                            ? controller.selectedDate!.value
                            : onTapSelectedDate), // Display default if not selected
                onTap: () => controller.pickDate(context),
                btnStyle: kSmallTitle1.copyWith(fontSize: 17.sp),
              ),

              20.height,

              CustomButton(
                title: controller.isLoading.value ? submitting : submit,
                onTap: () {
                  controller.updateAllHistory();
                },
              ),

              130.height,
            ],
          ),
        ),
      ),
    ),
  );
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
