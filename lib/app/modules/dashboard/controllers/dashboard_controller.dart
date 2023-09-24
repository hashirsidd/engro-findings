import 'package:get/get.dart';

class DashboardController extends GetxController {
  Map<String, List<int>> graph = {
    'pm&s': [2, 10],
    'urut\ni': [0, 0],
    'urea\nii': [7, 5],
    'urut\nii': [5, 3],
    'amm\nii': [4, 2],
    'amm\niii': [6, 0],
    'Work\nShop': [4, 4]
  };
  RxInt max = 0.obs;

  getMax() {
    int _max = 0;
    graph.forEach((key, value) {
      _max = value[0] + value[1];
      if (_max > max.value) {
        max.value = _max;
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    getMax();
  }
}
