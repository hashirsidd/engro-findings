import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:Findings/app/custom_widgets/widgets/appBar.dart';
import 'package:Findings/app/modules/findingsApproval/controllers/findings_approval_controller.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../custom_widgets/widgets/findings_card.dart';

class FindingsApprovalView extends GetView<FindingsApprovalController> {
  const FindingsApprovalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'FINDINGS APPROVAL',
      ),
      body: Obx(() => controller.unApprovedFindings.isEmpty && controller.isLoading.value == false
          ? const Center(
              child: Text(
              'No unapproved findings!',
              textAlign: TextAlign.center,
            ))
          : LiquidPullToRefresh(
              onRefresh: controller.reload,
              showChildOpacityTransition: false,
              color: Colors.transparent,
              backgroundColor: Colors.green,
              springAnimationDurationInMilliseconds: 500,
              animSpeedFactor: 2,
              height: 100,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                      onTap: () => controller.onTapCard(i),
                      child: FindingsCard(
                        title: controller.unApprovedFindings[i].title,
                        description: controller.unApprovedFindings[i].problem,
                        tag: controller.unApprovedFindings[i].equipmentTag,
                        category: controller.unApprovedFindings[i].category,
                        area: controller.unApprovedFindings[i].area,
                        date: controller.unApprovedFindings[i].date,
                      ));
                },
                itemCount: controller.unApprovedFindings.length,
              ),
            )),
    );
  }
}
