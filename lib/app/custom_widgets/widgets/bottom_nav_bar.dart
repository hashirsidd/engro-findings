import 'package:Findings/app/modules/home/controllers/home_controller.dart';
import 'package:Findings/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final HomeController controller;

  const BottomNavBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.pageIndex.value,
        onTap: (index) {
          controller.pageIndex.value = index;
          if(index==3){
            Get.toNamed(Routes.SEARCH_FINDINGS);
          }
        },
        elevation: 30,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: const TextStyle(color: Colors.black54),
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.green,
        selectedLabelStyle: const TextStyle(color: Colors.green),
        // Use shifting mode
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
