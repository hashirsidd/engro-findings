import 'package:get/get.dart';

import '../controllers/findings_approval_controller.dart';

class FindingsApprovalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindingsApprovalController>(
      () => FindingsApprovalController(),
    );
  }
}
