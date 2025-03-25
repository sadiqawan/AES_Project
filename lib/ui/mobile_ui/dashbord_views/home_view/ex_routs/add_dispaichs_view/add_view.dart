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
                Text('Type:       ${widget.type}', style: kSubTitle1),
                5.height,
                Text('Name:       ${widget.name}', style: kSubTitle1),
                5.height,
                Text('S.No:       ${widget.sNo}', style: kSubTitle1),
                5.height,

                Text('Model:      ${widget.model}', style: kSubTitle1),

                5.height,
                Text('Quantity:   ${widget.quantity}', style: kSubTitle1),
                5.height,
                Text('Cost:       ${widget.cost}', style: kSubTitle1),
                15.height,
                // Removed Flexible
                const Text(
                  'Enter Following fields for Update Available Stock.',
                ),
                const Text('Type,Name,Model and S.No must be same.'),
                20.height,

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
                8.height,

                // Responsive Form Fields
                isLandscape
                    ? Row(
                      children: [
                        Expanded(
                          child: _inPut(
                            enterItemName,
                            name,
                            controller.nameC,
                            Icons.insert_invitation_outlined,
                            false,
                          ),
                        ),
                        5.width,
                        Expanded(
                          child: _inPut(
                            enterSerialNo,
                            sNo,
                            controller.serialNoC,
                            Icons.segment_rounded,
                            false,
                          ),
                        ),
                      ],
                    )
                    : Column(
                      children: [
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
                      ],
                    ),
                10.height,
                _inPut(
                  modelNo,
                  model,
                  controller.modelC,
                  Icons.segment_rounded,
                  false,
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
                      widget.id,
                      upCost!,
                      upQuan!,
                    );
                  },
                ),
                30.height
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
