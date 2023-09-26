import 'package:get/get.dart';

import '../controllers/create_users_controller.dart';

class CreateUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUsersController>(
      () => CreateUsersController(),
    );
  }
}
