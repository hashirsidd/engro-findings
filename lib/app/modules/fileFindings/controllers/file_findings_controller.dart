import 'package:Findings/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/dialogs/submit_dialog.dart';

class FileFindingsController extends GetxController {
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

  RxString area = ''.obs;
  RxString category = ''.obs;
  RxString date = ''.obs;

  var categoryList = [
    'Machinery',
    'Stationary',
  ];
  var areaList = [
    'PM&S',
    'URUT-I',
    'UREA-II',
    'URUT-III',
    'AMM-II',
    'AMM-III',
  ];

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
