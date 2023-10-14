import 'package:Findings/app/custom_widgets/widgets/submit_findings_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Findings/app/custom_widgets/widgets/appBar.dart';

import '../controllers/edit_finding_controller.dart';

class EditFindingsView extends GetView {
  late final EditFindingsController controller;

  EditFindingsView() {
    this.controller = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Edit YOUR FINDINGS',
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SubmitFindingsForm(controller: controller),
      ),
    );
  }
}
