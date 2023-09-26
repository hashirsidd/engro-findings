import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/dialogs/submit_dialog.dart';
import '../../../routes/app_pages.dart';

class SubmittedFindingsController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController findingController = TextEditingController();
  TextEditingController equipmentDescriptionController =
      TextEditingController();
  TextEditingController equipmentTagController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  TextEditingController solutionController = TextEditingController();
  TextEditingController preventionController = TextEditingController();
  TextEditingController areaGlController = TextEditingController();
  TextEditingController createdByController = TextEditingController();
  FocusNode findingFocus = FocusNode();
  FocusNode equipmentDescriptionFocus = FocusNode();
  FocusNode equipmentTagFocus = FocusNode();
  FocusNode problemFocus = FocusNode();
  FocusNode solutionFocus = FocusNode();
  FocusNode preventionFocus = FocusNode();
  FocusNode areaGlFocus = FocusNode();

  String buttonText = 'Save';
  RxString area = ''.obs;
  RxString category = ''.obs;
  RxString date = ''.obs;

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
