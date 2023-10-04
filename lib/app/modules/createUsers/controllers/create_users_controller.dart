import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';

import '../../../custom_widgets/dialogs/submit_dialog.dart';

class CreateUsersController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userPasswordAgainController = TextEditingController();
  TextEditingController employeeCodeController = TextEditingController();

  RxString area = ''.obs;
  RxBool isAdmin = false.obs;
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode passwordAgainFocus = FocusNode();
  FocusNode codeFocus = FocusNode();

  // onPressCreateUser() {
  //   Share.share(
  //       'Email: ${userEmailController.text.trim()}\nPassword: ${userPasswordController.text.trim()}',
  //       subject: 'Account credentials');
  // }

  onPressCreateUser() async {
    if (usernameController.text.trim().isEmpty ||
        userEmailController.text.trim().isEmpty ||
        userPasswordController.text.trim().isEmpty ||
        userPasswordAgainController.text.trim().isEmpty ||
        employeeCodeController.text.trim().isEmpty ||
        area.value.trim().isEmpty) {
      CustomGetxWidgets.CustomSnackbar('Error', "All fields are required!");
    } else if (!userEmailController.text.trim().isEmail) {
      CustomGetxWidgets.CustomSnackbar('Error', "Email format is incorrect!");
    } else if (userPasswordController.text.trim() !=
        userPasswordAgainController.text.trim()) {
      CustomGetxWidgets.CustomSnackbar('Error', "Passwords do not match");
    } else if (userPasswordController.text.trim().length < 8) {
      CustomGetxWidgets.CustomSnackbar(
          'Error', "Passwords length must be at least 8 characters!");
    } else {
      Get.dialog(LoadingDialog(), barrierDismissible: false);
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmailController.text.trim(),
          password: userPasswordController.text.trim(),
        );

        User? user = userCredential.user;

        if (user != null) {
          try {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set({
              'name': usernameController.text.trim(),
              'email': userEmailController.text.trim(),
              'employeeCode': employeeCodeController.text.trim(),
              'area': area.value.trim(),
              'isLoginAllowed': true,
              'isAdmin': isAdmin.value,
              'profilePictureUrl': '',
              'notifications': true
            });
            Get.back();
            Get.offAllNamed(Routes.HOME);
            Get.dialog(
              SubmitDialog(
                title: 'User Created',
                description:
                    'Email: ${userEmailController.text.trim()}\nPassword: ${userPasswordController.text.trim()}',
                rightButtonText: 'OK',
                leftButtonText: 'Share',
                rightButtonOnTap: () {
                  Get.back();
                },
                leftButtonOnTap: () {
                  Share.share(
                      'Email: ${userEmailController.text.trim()}\nPassword: ${userPasswordController.text.trim()}',
                      subject: 'Account credentials');
                },
              ),
            );
            print('User created: ${user.uid}');
          } catch (e) {
            await user.delete();
            throw "Unable to create user data";
          }
        } else {
          Get.back();
          print("User creation failed!");
          throw "User creation failed!";
        }
      } catch (e) {
        Get.back();
        print("$e!");
        CustomGetxWidgets.CustomSnackbar(
            'Error', "Unable to create user!\nUnexpected error occurred!");
      }
    }
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
