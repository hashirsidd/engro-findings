import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/modules/home/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ManageUsersController extends GetxController {
  RxList<UserModel> usersList = <UserModel>[].obs;

  HomeController homeController = Get.find();

  Future<void> changeUserAdminStatus(int index) async {
    Get.dialog(const LoadingDialog());
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(usersList[index].uid)
          .update({'isAdmin': !usersList[index].isAdmin});
      usersList[index].isAdmin = !usersList[index].isAdmin;
      usersList.refresh();
    } catch (e) {
      print(e);
    } finally {
      Get.back();
    }
  }

  Future<void> changeUserBlockStatus(int index) async {
    Get.dialog(const LoadingDialog());
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(usersList[index].uid)
          .update({'isLoginAllowed': !usersList[index].isLoginAllowed});
      usersList[index].isLoginAllowed = !usersList[index].isLoginAllowed;
      usersList.refresh();
    } catch (e) {
      print(e);
    } finally {
      Get.back();
    }
  }

  Future<void> getUsers() async {
    Get.dialog(const LoadingDialog());
    try {
      QuerySnapshot<Map<String, dynamic>> usersData =
          await FirebaseFirestore.instance.collection('users').get();
      if (usersData.docs.isNotEmpty) {
        for (var element in usersData.docs) {
          usersList.add(UserModel.fromJson(element.data()));
        }
      }
    } catch (e) {
      print(e);
    } finally {
      Get.back();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await getUsers();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
