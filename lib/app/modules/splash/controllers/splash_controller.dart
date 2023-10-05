import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:Findings/app/routes/app_pages.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool logoVisible = false.obs;
  late AnimationController animationController;

  Future<bool> isUserLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }


  navigateAfterSplash() {
    Future.delayed(const Duration(seconds: 5), () async {
      if (await isUserLoggedIn()) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }

  initiateAnimation() {
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    Future.delayed(const Duration(seconds: 1), () {
      logoVisible.value = true;
      animationController.forward();
    });
  }

  @override
  void onInit() {
    super.onInit();
    initiateAnimation();
    navigateAfterSplash();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose(); // Dispose of the animation controller
    super.onClose();
  }
}
