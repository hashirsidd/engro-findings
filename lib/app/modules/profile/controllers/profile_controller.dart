import 'dart:typed_data';

import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/modules/home/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  late TextEditingController usernameController;
  late TextEditingController userEmailController;
  late TextEditingController employeeCodeController;
  RxString area = ''.obs;

  FocusNode emailFocus = FocusNode();
  FocusNode codeFocus = FocusNode();

  HomeController homeController = Get.find();

  RxString profilePictureUrl = ''.obs;

  Future<String?> uploadImageToFirebaseStorage(Uint8List imageFile) async {
    try {
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + homeController.user.value.uid;
      Reference storageReference = FirebaseStorage.instance.ref().child('images/$fileName');

      UploadTask uploadTask = storageReference.putData(imageFile);

      await uploadTask.whenComplete(() {});

      String downloadURL = await storageReference.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print("Error uploading image: $e");

      return null;
    }
  }

  onPressChangeProfilePicture() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage =
          await picker.pickImage(imageQuality: 50, source: ImageSource.gallery);
      if (pickedImage != null) {
        Get.dialog(LoadingDialog());
        Uint8List image = await pickedImage.readAsBytes();
        String? url = await uploadImageToFirebaseStorage(image);
        if (url != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(homeController.user.value.uid)
              .update({
            'profilePictureUrl': url,
          });
          homeController.user.value.profilePictureUrl = url;
          homeController.user.refresh();
        }
        Get.back();
      }
    } catch (e) {
      Get.back();
      print('error in onTapUploadImage : $e');
    }
  }

  onPressSave() async {
    if (usernameController.text.trim().isEmpty ||
        employeeCodeController.text.trim().isEmpty ||
        area.value.trim().isEmpty) {
      CustomGetxWidgets.CustomSnackbar('Error', "All fields are required!");
    } else {
      Get.dialog(LoadingDialog(), barrierDismissible: false);
      try {
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(homeController.user.value.uid)
              .update({
            'name': usernameController.text.trim(),
            "employeeCode": employeeCodeController.text.trim(),
            "area": area.value.trim(),
          });
          Get.back();
          homeController.user.value.name = usernameController.text.trim();
          homeController.user.value.employeeCode = employeeCodeController.text.trim();
          homeController.user.value.area = area.value.trim();
          Get.snackbar(
            'Success',
            "Profile updated successfully!",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } catch (e) {
          throw "Unable to create user data";
        }
      } catch (e) {
        Get.back();
        CustomGetxWidgets.CustomSnackbar(
          'Error',
          "Unable to create user!\nUnexpected error occurred!",
          color: Colors.red,
        );
      }
    }
  }

  @override
  void onInit() {
    usernameController = TextEditingController(text: homeController.user.value.name);
    userEmailController = TextEditingController(text: homeController.user.value.email);
    employeeCodeController = TextEditingController(text: homeController.user.value.employeeCode);
    area.value = homeController.user.value.area;
    profilePictureUrl.value = homeController.user.value.profilePictureUrl;
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
