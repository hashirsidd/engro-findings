import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  Rx<UserModel> user = UserModel().obs;
  RxInt newFindings = 0.obs;

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
        await getApprovalsCount();
      } else {
        throw 'User not found';
      }
      Get.back();
    } catch (e) {
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
