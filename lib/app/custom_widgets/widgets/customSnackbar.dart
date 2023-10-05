import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomGetxWidgets {
  static CustomSnackbar(String title, String message, {Color? color}) =>
      Get.snackbar(
        title,
        message,
        backgroundColor: color ?? Colors.green,
        colorText: Colors.white,
      );
}
