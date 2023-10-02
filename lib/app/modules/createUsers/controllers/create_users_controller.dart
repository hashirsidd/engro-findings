import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
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

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode passwordAgainFocus = FocusNode();
  FocusNode codeFocus = FocusNode();

  onPressCreateUser(){
  Share.share(
  'Email: ${userEmailController.text.trim()}\nPassword: ${userPasswordController.text.trim()}',
  subject: 'Account credentials');
}
  // onPressCreateUser() async {
  //   if (usernameController.text.trim().isEmpty ||
  //       userEmailController.text.trim().isEmpty ||
  //       userPasswordController.text.trim().isEmpty ||
  //       userPasswordAgainController.text.trim().isEmpty ||
  //       employeeCodeController.text.trim().isEmpty ||
  //       area.value.trim().isEmpty) {
  //     Get.snackbar('Error', "All fields are required!");
  //   } else if (!userEmailController.text.trim().isEmail) {
  //     Get.snackbar('Error', "Email format is incorrect!");
  //   } else if (userPasswordController.text.trim() !=
  //       userPasswordAgainController.text.trim()) {
  //     Get.snackbar('Error', "Passwords do not match");
  //   } else if (userPasswordController.text.trim().length < 8) {
  //     Get.snackbar('Error', "Passwords length must be at least 8 characters!");
  //   } else {
  //     Get.dialog(LoadingDialog(), barrierDismissible: false);
  //     try {
  //       UserCredential userCredential =
  //           await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: userEmailController.text.trim(),
  //         password: userPasswordController.text.trim(),
  //       );
  //
  //       User? user = userCredential.user;
  //
  //       if (user != null) {
  //         await FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(user.uid)
  //             .set({
  //           'name': usernameController.text.trim(),
  //           'email': userEmailController.text.trim(),
  //           'employeeCode': employeeCodeController.text.trim(),
  //           'area': area.value.trim(),
  //           'isLoginAllowed': true,
  //           'isAdmin': false,
  //           'profilePictureUrl': '',
  //         });
  //         Get.back();
  //         Get.offAllNamed(Routes.HOME);
  //         Get.dialog(
  //           SubmitDialog(
  //             title: 'User Created',
  //             description:
  //                 'User has been created with following credentials\nEmail: ${userEmailController.text.trim()}\nPassword: ${userPasswordController.text.trim()}',
  //             rightButtonText: 'OK',
  //             leftButtonText: 'Share',
  //             rightButtonOnTap: () {
  //               Get.back();
  //             },
  //             leftButtonOnTap: () {
  //               Share.share(
  //                   'Email: ${userEmailController.text.trim()}\nPassword: ${userPasswordController.text.trim()}',
  //                   subject: 'Account credentials');
  //             },
  //           ),
  //         );
  //         print('User created: ${user.uid}');
  //       } else {
  //         Get.back();
  //         Get.snackbar('Error', "User creation failed!");
  //       }
  //     } catch (e) {
  //       Get.back();
  //       Get.snackbar(
  //           'Error', "Unable to create user!\nUnexpected error occurred!");
  //     }
  //   }
  // }

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
