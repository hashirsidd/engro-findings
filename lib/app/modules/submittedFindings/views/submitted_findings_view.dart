import 'package:Findings/app/custom_widgets/widgets/appBar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../custom_widgets/widgets/findings_card.dart';
import '../controllers/submitted_findings_controller.dart';

class SubmittedFindingsView extends GetView<SubmittedFindingsController> {
  const SubmittedFindingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'SUBMITTED FINDINGS',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: Column(
          children: [
            FindingsCard(
              showStatus: true,
              status: Status.rejected,
            ),
            FindingsCard(
              showStatus: true,
              status: Status.accepted,
            ),
            FindingsCard(
              showStatus: true,
              status: Status.inReview,
            ),
          ],
        ),
      ),
    );
  }
}
