import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../custom_widgets/dialogs/forgot_password.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxBool isLoading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // The new user is now signed in, and you can access their User object.
      User? user = userCredential.user;
      return user;
    } catch (e) {
      print("Error creating user: $e");
      return null; // Return null if there's an error
    }
  }

  onTapForgotPassword(context) {
    FocusScope.of(context).unfocus();

    emailController.clear();
    passwordController.clear();
    Get.dialog(
      ForgotPasswordDialog(
        emailController: emailController,
      ),
      barrierDismissible: false,
    );
  }

  void onPressLogin() async {
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      login();

      // User? newUser = await createUserWithEmailAndPassword(
      //     emailController.text.trim(), passwordController.text.trim());
      //
      // if (newUser != null) {
      //   // User creation successful
      //   print('User created: ${newUser.uid}');
      // } else {
      //   // User creation failed
      //   print('User creation failed');
      // }
    } else {
      Get.snackbar(
        'Validation Error',
        'All fields are required',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void login() async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      isLoading.value = false;
      Get.offAllNamed('/home'); // Navigate to home after successful login
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Login Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
