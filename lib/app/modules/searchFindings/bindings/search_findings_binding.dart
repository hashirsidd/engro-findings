import 'package:get/get.dart';

import '../controllers/search_findings_controller.dart';

class SearchFindingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchFindingsController>(
      () => SearchFindingsController(),
    );
  }
}
