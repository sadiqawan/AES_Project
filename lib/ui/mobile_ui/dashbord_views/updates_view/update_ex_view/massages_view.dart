import 'package:ase/constant/cont_text.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/updates_view/updates_vm.dart';
import 'package:flutter/material.dart';
import 'package:ase/constant/const_style.dart';
import 'package:ase/extensions/size_box.dart';
import 'package:ase/widgets/costum_button.dart';
import 'package:ase/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MassagesView extends StatefulWidget {
  const MassagesView({super.key});

  @override
  State<MassagesView> createState() => _MassagesViewState();
}

class _MassagesViewState extends State<MassagesView> {
  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  UpdateController controller = Get.put(UpdateController());

  return Scaffold(
    appBar: AppBar(title: const Text('Update Your Team')),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title of Updates', style: kSubTitle2B),
          10.height,
          CustomTextField(
            hint: 'Enter title...',
            controller: controller.titleController,
            icon: Icons.title,
          ),
          15.height,
          Text('Message', style: kSubTitle2B),
          10.height,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.sp),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: controller.messageController,
              maxLines: 10,
              style: TextStyle(fontSize: 16.sp),
              decoration: const InputDecoration(
                hintText: 'Write your message here...',
                border: InputBorder.none,
              ),
            ),
          ),
          90.height,

          Obx(
            () => Center(
              child: SizedBox(
                width: 60.w,
                child: CustomButton(
                  title: controller.isLoading.value ? loading : 'Send',
                  onTap: () {
                    controller.updateMessage(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
