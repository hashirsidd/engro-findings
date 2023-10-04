import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Obx(() {
            final animationController = controller.animationController;
            return AnimatedOpacity(
              opacity: controller.logoVisible.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 3500),
              child: Container(
                height: 200.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/engro.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
