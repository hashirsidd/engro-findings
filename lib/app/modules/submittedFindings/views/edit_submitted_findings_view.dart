import 'package:Findings/app/modules/fileFindings/controllers/file_findings_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../custom_widgets/widgets/appBar.dart';
import '../../../custom_widgets/widgets/submit_findings_form.dart';
import '../controllers/submitted_findings_controller.dart';

class EditSubmittedFindingsView extends GetView {
  final FindingsController controller = Get.put(FindingsController());

  EditSubmittedFindingsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'EDIT FINDINGS',
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
