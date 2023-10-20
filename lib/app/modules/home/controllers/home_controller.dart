import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/dialogs/submit_dialog.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  Rx<UserModel> user = UserModel().obs;
  RxInt newFindings = 0.obs;

  static deleteFinding(String id, Function reload) async {
    Get.dialog(LoadingDialog());
    bool hasException = false;
    try {
      await FirebaseFirestore.instance.collection('findings').doc(id).delete();
    } catch (e) {
      print(e);
      hasException = true;
    } finally {
      Get.back();
      if (hasException) {
        CustomGetxWidgets.CustomSnackbar('Error', 'Pleases try again!', color: Colors.red);
      } else {
        await reload();
        Get.back();
        CustomGetxWidgets.CustomSnackbar('Success', 'Finding has been deleted');
      }
    }
  }

  static deleteFindingDialog(String id, Function reload) {
    Get.dialog(
      SubmitDialog(
        titleIcon: const Icon(Icons.delete, color: Colors.red, size: 100),
        title: 'Delete finding',
        description: 'This finding will be deleted permanently!',
        rightButtonText: 'Delete',
        leftButtonText: 'Cancel',
        rightButtonOnTap: () {
          Get.back();
          deleteFinding(id, reload);
        },
        leftButtonOnTap: () => Get.back(),
        titleTextColor: Colors.red,
      ),
    );
  }

  logoutUser() async {
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.SPLASH);
  }

  Future<void> getApprovalsCount() async {
    var findingsCount =
        await FirebaseFirestore.instance.collection('newFindings').doc("newFindings").get();
    if (findingsCount.data() != null) {
      newFindings.value = findingsCount.data()!['new'];
      print(newFindings.value);
    } else {
      throw 'error in getting new findings count';
    }
  }

  Future<void> getUserData() async {
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    try {
      var value = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid ?? "0")
          .get();
      if (value.data() != null) {
        user.value = UserModel.fromJson(value.data()!);
      } else {
        throw 'User not found';
      }
      Get.back();
    } catch (e) {
      print(e);
      await FirebaseAuth.instance.signOut();
      Get.back();
      Get.offAllNamed(Routes.SPLASH);
      CustomGetxWidgets.CustomSnackbar("Error", "Unable to get user data!");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getUserData();
  }
}
