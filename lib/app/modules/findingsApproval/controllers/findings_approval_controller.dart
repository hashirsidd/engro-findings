import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/data/findings_model.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/modules/findingsApproval/controllers/edit_finding_controller.dart';
import 'package:Findings/app/modules/findingsApproval/views/Approve_reject_finding.dart';
import 'package:Findings/app/modules/findingsApproval/views/edit_finding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindingsApprovalController extends GetxController {
  RxList<FindingsModel> unApprovedFindings = <FindingsModel>[].obs;
  RxBool isLoading = false.obs;
  List<String> findingsId = [];

  onTapEdit(int index) async {
    EditFindingsController editFindingsController = Get.put(EditFindingsController());
    editFindingsController.isApprovalEdit = true;
    editFindingsController.findingIndex = index;
    editFindingsController.titleController.text = unApprovedFindings[index].title;
    editFindingsController.area.value = unApprovedFindings[index].area;
    editFindingsController.date.value = unApprovedFindings[index].date;
    editFindingsController.category.value = unApprovedFindings[index].category;
    editFindingsController.equipmentTagController.text = unApprovedFindings[index].equipmentTag;
    editFindingsController.equipmentDescriptionController.text =
        unApprovedFindings[index].equipmentDescription;
    editFindingsController.problemController.text = unApprovedFindings[index].problem;
    editFindingsController.findingController.text = unApprovedFindings[index].finding;
    editFindingsController.solutionController.text = unApprovedFindings[index].solution;
    editFindingsController.preventionController.text = unApprovedFindings[index].prevention;
    editFindingsController.areaGlController.text = unApprovedFindings[index].areaGl;
    editFindingsController.createdByController.text = unApprovedFindings[index].createdByEmail;
    editFindingsController.images.value = List.from(unApprovedFindings[index].images);
    editFindingsController.findingId = unApprovedFindings[index].id;

    Get.to(() => EditFindingsView());
  }

  onTapReject(int index) async {
    try {
      Get.dialog(LoadingDialog(), barrierDismissible: false);
      await FirebaseFirestore.instance
          .collection('findings')
          .doc(findingsId[index])
          .update({'isApproved': 0});
      Get.back();
      Get.back();
      await loadData();
      CustomGetxWidgets.CustomSnackbar("Success", "Finding has been rejected!");
    } catch (e) {
      Get.back();
      print(e);
      CustomGetxWidgets.CustomSnackbar(
        "Error",
        "Please try again!",
        color: Colors.red,
      );
    }
  }

  onTapApprove(int index) async {
    try {
      Get.dialog(LoadingDialog(), barrierDismissible: false);
      await FirebaseFirestore.instance
          .collection('findings')
          .doc(findingsId[index])
          .update({'isApproved': 1});

      await FirebaseFirestore.instance.collection('overview').doc('graph').set({
        "${unApprovedFindings[index].area.toLowerCase()} ${unApprovedFindings[index].category.toLowerCase()}":
            FieldValue.increment(1)
      }, SetOptions(merge: true));

      Get.back();
      Get.back();
      await loadData();
      CustomGetxWidgets.CustomSnackbar("Success", "Finding has been approved!");
    } catch (e) {
      Get.back();
      print(e);
      CustomGetxWidgets.CustomSnackbar(
        "Error",
        "Please try again!",
        color: Colors.red,
      );
    }
  }

  onTapCard(int i) async {
    UserModel? user = await getUserDetails(unApprovedFindings[i].createdByUid);
    if (user != null) {
      Get.to(() => ApproveRejectFindingView(
            user: user,
            finding: unApprovedFindings[i],
            onTapApprove: () => onTapApprove(i),
            onTapReject: () => onTapReject(i),
            onTapEdit: () => onTapEdit(i),
            reload: loadData,
          ));
    }
  }

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

  Future<void> getApprovalsCount() async {
    unApprovedFindings.clear();
    findingsId.clear();
    try {
      isLoading.value = true;
      QuerySnapshot<Map<String, dynamic>> findings = await FirebaseFirestore.instance
          .collection('findings')
          .where('isApproved', isEqualTo: 2)
          .orderBy('timeStamp', descending: true)
          .get();
      if (findings.docs.isNotEmpty) {
        findings.docs.forEach((element) {
          findingsId.add(element.id);
          unApprovedFindings.add(FindingsModel.fromJson(element.data()));
        });
      }
    } catch (e) {
      print(e);
      throw e;
    }
    isLoading.value = false;
  }

  Future<void> reload() async {
    isLoading.value = true;
    try {
      await getApprovalsCount();
    } catch (e) {
      print(e);
      CustomGetxWidgets.CustomSnackbar('Error', 'Unable to get findings,\nPlease try again!',
          color: Colors.red);
    }
    isLoading.value = false;
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      Get.dialog(LoadingDialog());
      await getApprovalsCount();
      Get.back();
    } catch (e) {
      Get.back();
      Get.back();
      CustomGetxWidgets.CustomSnackbar('Error', 'Unable to get findings,\nPlease try again!',
          color: Colors.red);
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await loadData();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
