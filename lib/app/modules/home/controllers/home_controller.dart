import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {


  RxInt pageIndex = 0.obs;

  final TextEditingController searchController = TextEditingController();
}
