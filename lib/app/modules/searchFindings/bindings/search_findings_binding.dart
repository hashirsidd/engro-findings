import 'package:Findings/app/modules/searchFindings/controllers/search_result_controller.dart';
import 'package:get/get.dart';

import '../controllers/search_findings_controller.dart';

class SearchFindingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchFindingsController>(
      () => SearchFindingsController(),
    );
    Get.lazyPut<SearchResultController>(
      () => SearchResultController(),
    );
  }
}
