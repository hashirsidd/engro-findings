import 'package:Findings/app/modules/searchFindings/views/findings_details_view.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Findings/app/custom_widgets/widgets/appBar.dart';
import 'package:Findings/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:Findings/app/custom_widgets/widgets/chart.dart';

import 'package:Findings/app/custom_widgets/widgets/findings_card.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'OVERVIEW DASHBOARD',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Spacing.hStandard,
                    const Text(
                      'Stationary',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacing.hStandard,
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(3, 75, 8, 1.0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Spacing.hStandard,
                    const Text(
                      'Machinery',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Spacing.vLarge,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 7.0,
                      ),
                    ],
                  ),
                  child: CustomStackedColumnChart(
                    controller: controller,
                  ),
                ),
                Spacing.vLarge,
                const Text(
                  'Latest Updates',
                  style: TextStyle(fontSize: 28),
                ),
                Spacing.vLarge,
                GestureDetector(
                    onTap: () {
                      Get.to(() => const FindingDetailsView());
                    },
                    child: FindingsCard()),
                GestureDetector(
                    onTap: () {
                      Get.to(() => const FindingDetailsView());
                    },
                    child: FindingsCard()),
                GestureDetector(
                    onTap: () {
                      Get.to(() => const FindingDetailsView());
                    },
                    child: FindingsCard()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
