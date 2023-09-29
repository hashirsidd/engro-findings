import 'package:Findings/app/modules/findingsApproval/views/Approve_reject_finding.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:Findings/app/custom_widgets/widgets/appBar.dart';
import 'package:Findings/app/modules/findingsApproval/controllers/findings_approval_controller.dart';

import '../../../custom_widgets/widgets/findings_card.dart';

class FindingsApprovalView extends GetView<FindingsApprovalController> {
  const FindingsApprovalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'FINDINGS APPROVAL',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Get.to(() => const ApproveRejectFindingView());
                },
                child: const FindingsCard()),
            GestureDetector(
                onTap: () {
                  Get.to(() => const ApproveRejectFindingView());
                },
                child: const FindingsCard()),
            GestureDetector(
                onTap: () {
                  Get.to(() => const ApproveRejectFindingView());
                },
                child: const FindingsCard()),
          ],
        ),
      ),
    );
  }
}
