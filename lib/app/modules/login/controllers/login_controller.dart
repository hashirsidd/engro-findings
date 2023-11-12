import 'dart:async';

import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/modules/home/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Findings/app/custom_widgets/dialogs/forgot_password.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxBool isLoading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  onTapForgotPassword(context) {
    FocusScope.of(context).unfocus();

    emailController.clear();
    passwordController.clear();
    Get.dialog(
      ForgotPasswordDialog(
        onPress: onPressSendResetEmail,
      ),
      barrierDismissible: false,
    );
  }

  void onPressSendResetEmail(String email) async {
    if (email.isEmail) {
      Get.back();
      Get.dialog(LoadingDialog(), barrierDismissible: false);
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        Get.back();
        CustomGetxWidgets.CustomSnackbar('Success', 'Reset email has been sent to your account!');
      } catch (e) {
        Get.back();
        CustomGetxWidgets.CustomSnackbar("Error", 'Unexpected error occurred', color: Colors.red);
      }
    } else {
      CustomGetxWidgets.CustomSnackbar("Error", 'Invalid Email', color: Colors.red);
    }
  }

  void onPressLogin() async {
    if (emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty) {
      login();
    } else {
      Get.snackbar(
        'Validation Error',
        'All fields are required',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void login() async {
    late Timer timeoutTimer;
    try {
      isLoading.value = true;
      timeoutTimer = Timer(Duration(seconds: 15), () {
        timeoutTimer.cancel();
        throw 'Login operation timed out after 15 seconds';
      });
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      timeoutTimer.cancel();
      isLoading.value = false;
      Get.offAllNamed('/home');

      // Navigate to home after successful login
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Login Error',
          'User not found',
        );
      }
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        Get.snackbar(
          'Login Error',
          'Invalid Credentials',
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Login Error',
          'Wrong password',
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          'Login Error',
          'Invalid email',
        );
      } else if (e.code == 'user-disabled') {
        Get.snackbar(
          'Login Error',
          'Account disabled',
        );
      } else if (e.code == 'too-many-requests') {
        Get.snackbar(
          'Login Error',
          'Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later',
        );
      } else {
        print(e);
        print(e.code);
        Get.snackbar(
          'Login Error',
          'An error occurred: ${e.message}',
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Login Error',
        'An unexpected error occurred',
      );
    }
  }
}
