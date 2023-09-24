import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchFindingsController extends GetxController {
  FocusNode searchFocus = FocusNode();
  bool isFirstLoad = true;
  final count = 0.obs;

  getFocus(BuildContext context) {
    if (isFirstLoad) {
      FocusScope.of(context).requestFocus(searchFocus);
      isFirstLoad = false;
    }
  }




  void increment() => count.value++;
}
