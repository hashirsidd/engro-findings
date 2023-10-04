import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomGetxWidgets {
  static CustomSnackbar(title, message) => Get.snackbar(
        title,
        message,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

}
