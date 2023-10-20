import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/data/findings_model.dart';
import 'package:Findings/app/modules/home/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:Findings/app/custom_widgets/widgets/findings_card.dart';
import 'package:Findings/app/modules/findingsApproval/controllers/edit_finding_controller.dart';
import 'package:Findings/app/modules/findingsApproval/views/edit_finding.dart';

import '../../searchFindings/views/findings_details_view.dart';

class SubmittedFindingsController extends GetxController {
  RxList<FindingsModel> myFindings = <FindingsModel>[].obs;
  RxBool isLoading = false.obs;
  List<String> findingsId = [];


  onTapCard(int i) async {
    HomeController homeController = Get.find();
    Get.to(() => FindingDetailsView(
          user: homeController.user.value,
          finding: myFindings[i],
          reload: loadData,
        ));
  }

  onTapEdit(int index) async {
    EditFindingsController editFindingsController = Get.put(EditFindingsController());
    editFindingsController.isApprovalEdit = false;
    editFindingsController.findingIndex = index;
    editFindingsController.titleController.text = myFindings[index].title;
    editFindingsController.area.value = myFindings[index].area;
    editFindingsController.date.value = myFindings[index].date;
    editFindingsController.category.value = myFindings[index].category;
    editFindingsController.equipmentTagController.text = myFindings[index].equipmentTag;
    editFindingsController.equipmentDescriptionController.text =
        myFindings[index].equipmentDescription;
    editFindingsController.problemController.text = myFindings[index].problem;
    editFindingsController.findingController.text = myFindings[index].finding;
    editFindingsController.solutionController.text = myFindings[index].solution;
    editFindingsController.preventionController.text = myFindings[index].prevention;
    editFindingsController.areaGlController.text = myFindings[index].areaGl;
    editFindingsController.createdByController.text = myFindings[index].createdByEmail;
    editFindingsController.images.value = List.from(myFindings[index].images);
    editFindingsController.findingId = myFindings[index].id;
    Get.to(() => EditFindingsView());
  }

  Future<void> getMyFindings() async {
    myFindings.clear();
    findingsId.clear();
    try {
      QuerySnapshot<Map<String, dynamic>> findings = await FirebaseFirestore.instance
          .collection('findings')
          .where('createdByUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('timeStamp', descending: true)
          .get();
      if (findings.docs.isNotEmpty) {
        findings.docs.forEach((element) {
          findingsId.add(element.id);
          myFindings.add(FindingsModel.fromJson(element.data()));
        });
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      Get.dialog(LoadingDialog());
      await getMyFindings();
      Get.back();
    } catch (e) {
      Get.back();
      Get.back();
      CustomGetxWidgets.CustomSnackbar('Error', 'Unable to get findings,\nPlease try again!',
          color: Colors.red);
    }
    isLoading.value = false;
  }

  Status getStatusFromInt(int statusValue) {
    switch (statusValue) {
      case 0:
        return Status.rejected;
      case 1:
        return Status.accepted;
      case 2:
        return Status.inReview;
      default:
        return Status.inReview;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
