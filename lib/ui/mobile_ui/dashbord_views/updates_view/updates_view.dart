import 'package:ase/constant/cont_colors.dart';
import 'package:ase/constant/cont_text.dart';
import 'package:ase/ui/mobile_ui/dashbord_views/updates_view/update_ex_view/massages_view.dart';
import 'package:ase/widgets/custom_snakBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../widgets/update_card.dart';

class UpdatesView extends StatelessWidget {
  const UpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBlack,
        onPressed: () {
          Get.to(() => MassagesView());
        },
        child: const Icon(Icons.add_alert, color: kWhite),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kSecondaryColor,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        title: const Text('Updates', style: TextStyle(color: kWhite)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('updates')
                .orderBy('timestamp', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No Updates yet...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                var update = doc.data() as Map<String, dynamic>;
                final _userEmail = update['userEmail'];
                return GestureDetector(
                  onLongPress: () => _showDeleteDialog(context, doc.id, update['userId']),

                  child: UpdateCard(
                    title: update['title'] ?? 'No Title',
                    message: update['message'] ?? 'No Message',
                    userName: update['userName'] ?? 'Anonymous',
                    userEmail: update['userEmail'] ?? 'No Email',
                    timestamp:
                        update['timestamp'] != null
                            ? (update['timestamp'] as Timestamp).toDate()
                            : DateTime.now(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String docId, String updateUserId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kBlack,
        title: const Text("Delete Update", style: TextStyle(color: kWhite)),
        content: const Text("Are you sure you want to delete this update?", style: TextStyle(color: kWhite)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: kWhite)),
          ),
          TextButton(
            onPressed: () async {
              final currentUser = FirebaseAuth.instance.currentUser;
              if (currentUser != null && currentUser.uid == updateUserId) {
                await FirebaseFirestore.instance
                    .collection('updates')
                    .doc(docId)
                    .delete();
                Navigator.pop(context);

                SuccessSnackbar.show(
                  title: success,
                  message: 'Update successfully deleted',
                );
              } else {
                Navigator.pop(context);

                ErrorSnackbar.show(
                  title: failed,
                  message: 'You can only delete your own updates!',
                );
              }
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

}
