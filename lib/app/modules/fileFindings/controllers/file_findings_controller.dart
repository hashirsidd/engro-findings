import 'dart:typed_data';
import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/data/findings_model.dart';
import 'package:Findings/app/modules/home/controllers/home_controller.dart';
import 'package:Findings/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:Findings/app/custom_widgets/dialogs/submit_dialog.dart';

class FindingsController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController findingController = TextEditingController();
  TextEditingController equipmentDescriptionController = TextEditingController();
  TextEditingController equipmentTagController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  TextEditingController solutionController = TextEditingController();
  TextEditingController preventionController = TextEditingController();
  TextEditingController areaGlController = TextEditingController();
  TextEditingController createdByController = TextEditingController();

  FocusNode findingFocus = FocusNode();
  FocusNode equipmentDescriptionFocus = FocusNode();
  FocusNode equipmentTagFocus = FocusNode();
  FocusNode problemFocus = FocusNode();
  FocusNode solutionFocus = FocusNode();
  FocusNode preventionFocus = FocusNode();
  FocusNode areaGlFocus = FocusNode();

  String buttonText = 'Submit';
  RxString area = ''.obs;
  RxString category = ''.obs;
  RxString date = ''.obs;
  RxList images = [].obs;

  HomeController homeController = Get.find();

  onPressSubmit() {}

  removeImage(int index) {
    images.removeAt(index);
  }

  Future<String?> uploadImageToFirebaseStorage(Uint8List imageFile) async {
    try {
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + homeController.user.value.uid;
      print(fileName);
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

  onTapUploadImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> pickedImages = await picker.pickMultiImage(imageQuality: 50);
      if (pickedImages.isNotEmpty) {
        pickedImages.forEach((element) async {
          images.add(await element.readAsBytes());
        });
      }
    } catch (e) {
      CustomGetxWidgets.CustomSnackbar('Error', 'Error in image!');
      print('error in onTapUploadImage : $e');
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    findingController.dispose();
    equipmentDescriptionController.dispose();
    equipmentTagController.dispose();
    problemController.dispose();
    solutionController.dispose();
    preventionController.dispose();
    areaGlController.dispose();
    createdByController.dispose();

    findingFocus.dispose();
    equipmentDescriptionFocus.dispose();
    equipmentTagFocus.dispose();
    problemFocus.dispose();
    solutionFocus.dispose();
    preventionFocus.dispose();
    areaGlFocus.dispose();

    // Clear the images list
    images.clear();

    super.onClose();
  }
}

class FileFindingsController extends FindingsController {
  @override
  onPressSubmit() async {
    bool isDialogClose = false;

    // Get.offNamedUntil('home', (route) => false);
    if (titleController.text.trim().isEmpty ||
        area.value.isEmpty ||
        date.value.isEmpty ||
        category.value.isEmpty ||
        equipmentTagController.text.trim().isEmpty ||
        equipmentDescriptionController.text.trim().isEmpty ||
        problemController.text.trim().isEmpty ||
        findingController.text.trim().isEmpty ||
        solutionController.text.trim().isEmpty ||
        preventionController.text.trim().isEmpty ||
        areaGlController.text.trim().isEmpty) {
      CustomGetxWidgets.CustomSnackbar('Error', 'All Fields are required!');
    } else {
      Get.dialog(LoadingDialog());
      if (images.isNotEmpty) {
        var dummyImageList = images;
        for (int i = 0; i < images.length; i++) {
          String? imagePath = await uploadImageToFirebaseStorage(images[i]);
          if (imagePath == null) {
            isDialogClose = true;
            Get.back();
            CustomGetxWidgets.CustomSnackbar('Error', 'Unable to upload images\n Please try again!',
                color: Colors.red);
            images = dummyImageList;
            throw 'Error uploading images';
          } else {
            images[i] = imagePath;
          }
        }
      }

      FindingsModel findings = FindingsModel(
        title: titleController.text.trim(),
        area: area.value,
        date: date.value,
        category: category.value,
        equipmentTag: equipmentTagController.text.trim(),
        equipmentDescription: equipmentDescriptionController.text.trim(),
        problem: problemController.text.trim(),
        finding: findingController.text.trim(),
        solution: solutionController.text.trim(),
        prevention: preventionController.text.trim(),
        images: images.value,
        status: 2,
        createdByEmail: homeController.user.value.email,
        createdByUid: homeController.user.value.uid,
        timeStamp: FieldValue.serverTimestamp(),
        areaGl: areaGlController.text.trim(),
      );
      debugPrint(findings.toJson().toString());
      try {
        await FirebaseFirestore.instance.collection('findings').add(findings.toJson());
        await FirebaseFirestore.instance
            .collection('newFindings')
            .doc('newFindings')
            .set({'new': FieldValue.increment(1)});
        homeController.newFindings.value++;
        Get.back();
        Get.until((route) => route.settings.name == Routes.HOME);
        Get.dialog(
          SubmitDialog(
            title: 'Thank you for\nyour submission!',
            description: 'Your finding has been submitted\nfor review.',
            rightButtonText: 'OK',
            leftButtonText: 'Submit New',
            rightButtonOnTap: () => Get.back(),
            leftButtonOnTap: () {
              Get.back();
              Get.toNamed(Routes.FILE_FINDINGS);
            },
          ),
        );
      } catch (e) {
        if (isDialogClose) {
          Get.back();
        }
        CustomGetxWidgets.CustomSnackbar('Error', 'Please try again!', color: Colors.red);
        debugPrint('Error in uploading new findings : $e');
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
