import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController employeeCodeController = TextEditingController();

  RxString area = ''.obs;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode codeFocus = FocusNode();

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
