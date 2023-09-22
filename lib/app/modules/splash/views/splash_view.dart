import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';


class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Obx(() {
            final animationController = controller.animationController;
            return AnimatedOpacity(
              opacity: controller.logoVisible.value ? 1.0 : 0.0,
              duration: const Duration(seconds: 2),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0), 
                  end: const Offset(0.0, 0.0), 
                ).animate(CurvedAnimation(
                  curve: Curves.easeInOut,
                  parent: animationController,
                )),
                child:Container(
                  height: 200.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/engro.png'), 
                      fit: BoxFit.contain,
                    ),
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
