import 'package:Findings/app/custom_widgets/widgets/findings_detail_view.dart';
import 'package:Findings/app/data/findings_model.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/modules/searchFindings/views/findings_details_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/dialogs/loading_dialog.dart';
import '../../../custom_widgets/widgets/customSnackbar.dart';

class DashboardController extends GetxController {
  RxList<FindingsModel> findings = <FindingsModel>[].obs;

  Future<UserModel?> getUserDetails(String uid) async {
    UserModel? user;
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    try {
      var value = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (value.data() != null) {
        user = UserModel.fromJson(value.data()!);
      } else {
        throw 'User not found';
      }
      Get.back();
    } catch (e) {
      Get.back();
      CustomGetxWidgets.CustomSnackbar("Error", "Unable to get user data!", color: Colors.red);
    }
    return user;
  }

  onTapCard(int i) async {
    UserModel? user = await getUserDetails(findings[i].createdByUid);
    if (user != null) {
      Get.to(() => FindingDetailView(
            user: user,
            finding: findings[i],
          ));
    }
  }

  Map<String, List<int>> graph = {
    'pm&s': [2, 10],
    'urut\ni': [1, 1],
    'urea\nii': [7, 5],
    'urut\nii': [5, 3],
    'amm\nii': [4, 2],
    'amm\niii': [6, 0],
    'Work\nShop': [4, 4]
  };
  RxInt max = 0.obs;

  getMax() {
    int _max = 0;
    graph.forEach((key, value) {
      _max = value[0] + value[1];
      if (_max > max.value) {
        max.value = _max;
      }
    });
  }

  Future<void> loadData() async {
    try {
      Get.dialog(LoadingDialog());
      QuerySnapshot<Map<String, dynamic>> findingsData = await FirebaseFirestore.instance
          .collection('findings')
          .where('isApproved', isEqualTo: 1)
          .orderBy('timeStamp', descending: true)
          .limit(5)
          .get();
      if (findingsData.docs.isNotEmpty) {
        findingsData.docs.forEach((element) {
          findings.add(FindingsModel.fromJson(element.data()));
        });
      }
      Get.back();
    } catch (e) {
      Get.back();
      Get.back();
      CustomGetxWidgets.CustomSnackbar('Error', 'Unable to get findings,\nPlease try again!',
          color: Colors.red);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getMax();
  }

  @override
  void onReady() async {
    super.onReady();
    await loadData();
  }
}
