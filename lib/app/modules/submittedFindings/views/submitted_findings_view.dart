import 'package:Findings/app/custom_widgets/widgets/appBar.dart';
import 'package:Findings/app/modules/searchFindings/views/findings_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Findings/app/custom_widgets/widgets/findings_card.dart';
import 'package:Findings/app/modules/submittedFindings/controllers/submitted_findings_controller.dart';

class SubmittedFindingsView extends GetView<SubmittedFindingsController> {
  const SubmittedFindingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'SUBMITTED FINDINGS',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => const FindingDetailsView());
              },
              child: const FindingsCard(
                showStatus: true,
                status: Status.rejected,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const FindingDetailsView());
              },
              child: const FindingsCard(
                showStatus: true,
                status: Status.accepted,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const FindingDetailsView());
              },
              child: const FindingsCard(
                showStatus: true,
                status: Status.inReview,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
