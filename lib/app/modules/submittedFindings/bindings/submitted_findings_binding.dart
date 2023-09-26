import 'package:get/get.dart';

import '../controllers/submitted_findings_controller.dart';

class SubmittedFindingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmittedFindingsController>(
      () => SubmittedFindingsController(),
    );
  }
}
