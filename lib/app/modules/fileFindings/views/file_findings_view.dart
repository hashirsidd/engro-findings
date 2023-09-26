import 'package:Findings/app/custom_widgets/dialogs/submit_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/drop_down.dart';
import 'package:Findings/app/custom_widgets/widgets/findings_text_field.dart';
import 'package:Findings/app/custom_widgets/widgets/submit_findings_form.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Findings/app/custom_widgets/widgets/appBar.dart';
import 'package:Findings/app/modules/fileFindings/controllers/file_findings_controller.dart';

class FileFindingsView extends GetView<FileFindingsController> {
  const FileFindingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'FILE YOUR FINDINGS',
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
