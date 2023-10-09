import 'package:Findings/app/modules/fileFindings/controllers/file_findings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/dialogs/submit_dialog.dart';
import '../../../routes/app_pages.dart';

class SubmittedFindingsController extends FindingsController {
  @override
  onPressSubmit() {
    Get.offAllNamed(Routes.HOME);
    Get.dialog(
      SubmitDialog(
        title: 'Thank you for\nyour submission!',
        description: 'Your finding has been submitted\nfor review.',
        rightButtonText: 'OK',
        leftButtonText: 'Submit New',
        rightButtonOnTap: () => Get.back(),
        leftButtonOnTap: () {
          Get.back();
          Get.toNamed(Routes.FILE_FINDINGS);
        },
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
