import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/custom_widgets/widgets/findings_detail_view.dart';
import 'package:Findings/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/dialogs/loading_dialog.dart';
import '../../../data/findings_model.dart';
import '../../../data/user_model.dart';

class SearchFindingsController extends GetxController {
  FocusNode searchFocus = FocusNode();
  bool isFirstLoad = true;
  TextEditingController searchController = TextEditingController();
  RxList<FindingsModel> allFindings = <FindingsModel>[].obs;
  RxList<FindingsModel> pinnedFindings = <FindingsModel>[].obs;
  ScrollController scrollController = ScrollController();

  RxBool isSearching = false.obs;
  RxBool hasMoreData = true.obs;

  Future<UserModel?> getUserDetails(String uid) async {
    UserModel? user;
    Get.dialog(const LoadingDialog(), barrierDismissible: false);
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

  onTapCard(FindingsModel finding) async {
    UserModel? user = await getUserDetails(finding.createdByUid);
    if (user != null) {
      Get.to(() => FindingDetailView(
            user: user,
            finding: finding,
            reload: loadData,
          ));
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadMoreFindings();
    }
  }

  loadMoreFindings() async {
    if (hasMoreData.value) {
      try {
        isSearching.value = true;
        DocumentSnapshot<Map<String, dynamic>> lastDoc =
            await FirebaseFirestore.instance.collection('findings').doc(allFindings.last.id).get();
        if (lastDoc.data() != null) {
          QuerySnapshot<Map<String, dynamic>> addFindingsData = await FirebaseFirestore.instance
              .collection('findings')
              .where('isApproved', isEqualTo: 1)
              .where('pinned', isEqualTo: false)
              .orderBy('timeStamp', descending: true)
              .startAfterDocument(lastDoc)
              .limit(30)
              .get();
          if (addFindingsData.docs.isNotEmpty) {
            addFindingsData.docs.forEach((element) {
              allFindings.add(FindingsModel.fromJson(element.data()));
            });
          } else {
            hasMoreData.value = false;
          }
        } else {
          hasMoreData.value = false;
        }
      } catch (e) {
        print(e);
      } finally {
        isSearching.value = false;
      }
    }
  }

  Future<void> loadData() async {
    try {
      Get.dialog(const LoadingDialog());
      pinnedFindings.clear();
      allFindings.clear();
      QuerySnapshot<Map<String, dynamic>> findingsData = await FirebaseFirestore.instance
          .collection('findings')
          .where('isApproved', isEqualTo: 1)
          .where('pinned', isEqualTo: true)
          .orderBy('timeStamp', descending: true)
          .get();
      if (findingsData.docs.isNotEmpty) {
        findingsData.docs.forEach((element) {
          pinnedFindings.add(FindingsModel.fromJson(element.data()));
        });
      }
      pinnedFindings.refresh();
      QuerySnapshot<Map<String, dynamic>> allFindingsData = await FirebaseFirestore.instance
          .collection('findings')
          .where('isApproved', isEqualTo: 1)
          .where('pinned', isEqualTo: false)
          .orderBy('timeStamp', descending: true)
          .limit(30)
          .get();
      if (allFindingsData.docs.isNotEmpty) {
        allFindingsData.docs.forEach((element) {
          allFindings.add(FindingsModel.fromJson(element.data()));
        });
        allFindings.refresh();
      }
      Get.back();
    } catch (e) {
      print(e);
      Get.back();
      Get.back();
      CustomGetxWidgets.CustomSnackbar('Error', 'Unable to get findings,\nPlease try again!',
          color: Colors.red);
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(scrollListener);
  }

  @override
  void onReady() async {
    super.onReady();
    await loadData();
  }
}
