import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/data/findings_model.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/dialogs/submit_dialog.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  Rx<UserModel> user = UserModel().obs;
  RxInt newFindings = 0.obs;

  FocusNode newPasswordFocus = FocusNode();
  FocusNode oldPasswordFocus = FocusNode();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();

  changeNotificationStatus() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.value.uid)
        .update({'notifications': user.value.notifications});
  }

  onPressChangePassword() async {
    if (oldPasswordController.text.trim().isEmpty || newPasswordController.text.trim().isEmpty) {
      CustomGetxWidgets.CustomSnackbar('Error', "All fields are required!");
    } else if (newPasswordController.text.trim().length < 8) {
      CustomGetxWidgets.CustomSnackbar('Error', "Passwords length must be at least 8 characters!");
    } else {
      Get.dialog(const LoadingDialog(), barrierDismissible: false);
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: this.user.value.email,
          password: oldPasswordController.text.trim(),
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
        if (userCredential.user != null) {
          try {
            await FirebaseAuth.instance.currentUser!
                .updatePassword(newPasswordController.text.trim());
            Get.back();
            Get.back();
            CustomGetxWidgets.CustomSnackbar('Success', "Your passwords has been changed!");
          } catch (e) {
            print(e);
            throw "Unable to create user data";
          }
        } else {
          throw "User creation failed!";
        }
      } on FirebaseAuthException catch (e) {
        print(e);
        Get.back();
        Get.back();
        if (e.code == 'email-already-in-use') {
          CustomGetxWidgets.CustomSnackbar(
            'Error',
            "User already exists",
            color: Colors.red,
          );
        }
        if (e.code == 'invalid-email') {
          CustomGetxWidgets.CustomSnackbar(
            'Error',
            "Invalid email",
            color: Colors.red,
          );
        } else if (e.code == 'weak-password') {
          CustomGetxWidgets.CustomSnackbar(
            'Error',
            "Weak password",
            color: Colors.red,
          );
        } else if (e.code == 'wrong-password') {
          CustomGetxWidgets.CustomSnackbar(
            'Error',
            "Wrong password",
            color: Colors.red,
          );
        } else {
          CustomGetxWidgets.CustomSnackbar(
            'Error',
            'An error occurred: ${e.message}',
            color: Colors.red,
          );
        }
      } catch (e) {
        print(e);
        Get.back();
        Get.back();
        CustomGetxWidgets.CustomSnackbar(
          'Error',
          "Unable to create user!\nUnexpected error occurred!",
          color: Colors.red,
        );
      }
    }
  }

  static pinFinding(String id, Function reload, bool pinned) async {
    Get.dialog(
      SubmitDialog(
        titleIcon: const Icon(Icons.add_chart, color: Colors.green, size: 100),
        title: '${pinned ? "Unpin" : 'Pin'} finding',
        description: 'This finding will be ${pinned ? "unpinned" : 'pinned'}!',
        rightButtonText: pinned ? "Unpin" : 'Pin',
        leftButtonText: 'Cancel',
        rightButtonOnTap: () async {
          Get.back();
          Get.dialog(const LoadingDialog());
          bool hasException = false;
          try {
            DocumentSnapshot<Map<String, dynamic>> finding =
                await FirebaseFirestore.instance.collection('findings').doc(id).get();
            if (finding.data() != null) {
              FindingsModel findingsModel = FindingsModel.fromJson(finding.data()!);
              await FirebaseFirestore.instance
                  .collection('findings')
                  .doc(id)
                  .set({'pinned': !findingsModel.pinned}, SetOptions(merge: true));
            }
          } catch (e) {
            print(e);
            hasException = true;
          } finally {
            Get.back();
            if (hasException) {
              Get.back();
              CustomGetxWidgets.CustomSnackbar('Error', 'Pleases try again!', color: Colors.red);
            } else {
              await reload();
              CustomGetxWidgets.CustomSnackbar(
                  'Success', 'Finding has been ${pinned ? "unpinned" : 'pinned'}');
            }
          }
        },
        leftButtonOnTap: () => Get.back(),
      ),
    );
  }

  static deleteFinding(String id, Function reload) async {
    Get.dialog(const LoadingDialog());
    bool hasException = false;
    try {
      DocumentSnapshot<Map<String, dynamic>> finding =
          await FirebaseFirestore.instance.collection('findings').doc(id).get();
      if (finding.data() != null) {
        FindingsModel findingsModel = FindingsModel.fromJson(finding.data()!);
        await FirebaseFirestore.instance.collection('overview').doc('graph').set({
          "${findingsModel.area.toLowerCase()} ${findingsModel.category.toLowerCase()}":
              FieldValue.increment(-1)
        }, SetOptions(merge: true));
      }
      await FirebaseFirestore.instance.collection('findings').doc(id).delete();
    } catch (e) {
      print(e);
      hasException = true;
    } finally {
      Get.back();
      if (hasException) {
        CustomGetxWidgets.CustomSnackbar('Error', 'Pleases try again!', color: Colors.red);
      } else {
        await reload();
        Get.back();
        CustomGetxWidgets.CustomSnackbar('Success', 'Finding has been deleted');
      }
    }
  }

  static deleteFindingDialog(String id, Function reload) {
    Get.dialog(
      SubmitDialog(
        titleIcon: const Icon(Icons.delete, color: Colors.red, size: 100),
        title: 'Delete finding',
        description: 'This finding will be deleted permanently!',
        rightButtonText: 'Delete',
        leftButtonText: 'Cancel',
        rightButtonOnTap: () {
          Get.back();
          deleteFinding(id, reload);
        },
        leftButtonOnTap: () => Get.back(),
        titleTextColor: Colors.red,
      ),
    );
  }

  logoutUser() async {
    Get.dialog(const LoadingDialog(), barrierDismissible: false);
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.SPLASH);
  }

  Future<void> getApprovalsCount() async {
    var findingsCount =
        await FirebaseFirestore.instance.collection('newFindings').doc("newFindings").get();
    if (findingsCount.data() != null) {
      newFindings.value = findingsCount.data()!['new'];
      print(newFindings.value);
    } else {
      throw 'error in getting new findings count';
    }
  }

  Future<void> getUserData() async {
    Get.dialog(const LoadingDialog(), barrierDismissible: false);
    try {
      var value = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid ?? "0")
          .get();
      if (value.data() != null) {
        user.value = UserModel.fromJson(value.data()!);
      } else {
        throw 'User not found';
      }
      Get.back();
    } catch (e) {
      print(e);
      await FirebaseAuth.instance.signOut();
      Get.back();
      Get.offAllNamed(Routes.SPLASH);
      CustomGetxWidgets.CustomSnackbar("Error", "Unable to get user data!");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getUserData();
  }
}
