import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:Findings/app/custom_widgets/widgets/appBar.dart';
import 'package:Findings/app/modules/findingsApproval/controllers/findings_approval_controller.dart';

class FindingsApprovalView extends GetView<FindingsApprovalController> {
  const FindingsApprovalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'FINDINGS APPROVAL',
      ),
      body: Center(
        child: Text(
          'FindingsApprovalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
