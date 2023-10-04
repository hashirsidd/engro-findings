import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  logoutUser() async {
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.SPLASH);
  }
}
