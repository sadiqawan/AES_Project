import 'package:ase/constant/const_style.dart';
import 'package:ase/constant/cont_colors.dart';
import 'package:ase/extensions/size_box.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/item_listing_view/add_item_vm.dart';
import 'package:ase/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  AddItemController _controller = Get.put(AddItemController());

  List<String> list = ['Switch', 'Router', 'FireWall', 'Server', 'Other'];

  return Scaffold(
    appBar: AppBar(centerTitle: true, title: const Text('List Item')),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          5.height,
          Text(
            'Select Product Type',
            style: kSmallTitle1.copyWith(fontSize: 17.sp),
          ),
          5.height,
          DropdownButtonFormField<String>(
            dropdownColor: kSecondaryColor,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            hint: Text(
              'Select Item',
              style: kSmallTitle1.copyWith(fontSize: 17.sp),
            ),
            items:
                list.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (String? value) {
              print('Selected: $value');
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
          _inPut('If Other Enter Product Name (Optional)','Name', _controller.nameC),
        ],
      ),
    ),
  );
}

Widget _inPut(String title, String hint, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: kSmallTitle1.copyWith(fontSize: 17.sp)),
      CustomTextField(
        hint: hint,
        controller: controller,
        icon: Icons.insert_invitation_outlined,
      ),
    ],
  );
}
