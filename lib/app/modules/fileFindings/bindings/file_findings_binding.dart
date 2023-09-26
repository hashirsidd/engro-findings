import 'package:get/get.dart';

import '../controllers/file_findings_controller.dart';

class FileFindingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileFindingsController>(
      () => FileFindingsController(),
    );
  }
}
