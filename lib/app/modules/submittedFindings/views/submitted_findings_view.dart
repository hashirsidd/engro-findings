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
      floatingActionButton: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 7.0,
            ),
          ],
          color: Colors.green,
          borderRadius: BorderRadius.circular(150),
        ),
        child: const Icon(
          Icons.download,
          color: Colors.white,
          size: 31,
        ),
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
