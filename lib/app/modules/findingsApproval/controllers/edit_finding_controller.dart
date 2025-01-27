import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/data/findings_model.dart';
import 'package:Findings/app/modules/fileFindings/controllers/file_findings_controller.dart';
import 'package:Findings/app/modules/findingsApproval/controllers/findings_approval_controller.dart';
import 'package:Findings/app/modules/submittedFindings/controllers/submitted_findings_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../routes/app_pages.dart';
import 'package:intl/intl.dart';

class EditFindingsController extends FindingsController {
  int findingIndex = 0;
  bool isApprovalEdit = true;

  @override
  onPressSubmit() async {
    if (titleController.text.trim().isEmpty ||
        area.value.isEmpty ||
        date.value.isEmpty ||
        category.value.isEmpty ||
        equipmentTagController.text.trim().isEmpty ||
        equipmentDescriptionController.text.trim().isEmpty ||
        problemController.text.trim().isEmpty ||
        findingController.text.trim().isEmpty ||
        solutionController.text.trim().isEmpty ||
        preventionController.text.trim().isEmpty ||
        areaGlController.text.trim().isEmpty) {
      CustomGetxWidgets.CustomSnackbar('Error', 'All Fields are required!');
    } else {
      Get.dialog(const LoadingDialog());

      if (images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          if (images[i] is! String) {
            String? imagePath = await uploadImageToFirebaseStorage(images[i]);
            if (imagePath == null) {
              Get.back();
              CustomGetxWidgets.CustomSnackbar(
                  'Error', 'Unable to upload images\n Please try again!',
                  color: Colors.red);
            } else {
              images[i] = imagePath;
            }
          }
        }
      }

      FindingsModel finding = FindingsModel(
        title: titleController.text.trim().toLowerCase(),
        area: area.value.toLowerCase(),
        date: date.value,
        category: category.value.toLowerCase(),
        equipmentTag: equipmentTagController.text.trim().toLowerCase(),
        equipmentDescription: equipmentDescriptionController.text.trim().toLowerCase(),
        problem: problemController.text.trim(),
        finding: findingController.text.trim(),
        solution: solutionController.text.trim(),
        prevention: preventionController.text.trim(),
        images: images.value,
        status: 2,
        createdByEmail: homeController.user.value.email,
        createdByUid: homeController.user.value.uid,
        timeStamp: DateFormat('MM/dd/y').parse(date.value).millisecondsSinceEpoch,
        areaGl: areaGlController.text.trim(),
        id: '',
        pinned: false,
      );
      try {
        if (isApprovalEdit) {
          FindingsApprovalController findingsApprovalController = Get.find();
          finding.createdByUid =
              findingsApprovalController.unApprovedFindings[findingIndex].createdByUid;
          finding.createdByEmail =
              findingsApprovalController.unApprovedFindings[findingIndex].createdByEmail;
          finding.id = findingsApprovalController.findingsId[findingIndex];
          await FirebaseFirestore.instance
              .collection('findings')
              .doc(findingsApprovalController.findingsId[findingIndex])
              .set(finding.toJson());
          findingsApprovalController.unApprovedFindings[findingIndex] =
              FindingsModel.fromJson(finding.toJson());
          findingsApprovalController.unApprovedFindings.refresh();
          super.dispose();
          Get.back();
          Get.until((route) => route.settings.name == Routes.FINDINGS_APPROVAL);
        } else {
          SubmittedFindingsController submittedFindingsController = Get.find();
          finding.id = submittedFindingsController.findingsId[findingIndex];
          await FirebaseFirestore.instance
              .collection('findings')
              .doc(submittedFindingsController.findingsId[findingIndex])
              .set(finding.toJson(), SetOptions(merge: true));
          submittedFindingsController.myFindings[findingIndex] =
              FindingsModel.fromJson(finding.toJson());
          submittedFindingsController.myFindings.refresh();
          super.dispose();
          Get.back();
          Get.back();
        }
      } catch (e) {
        Get.back();
        CustomGetxWidgets.CustomSnackbar('Error', 'Please try again!', color: Colors.red);
        debugPrint('Error in uploading new findings : $e');
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
