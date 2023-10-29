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
        body: Obx(
          () => controller.myFindings.isEmpty && controller.isLoading.value == false
              ? const Center(
                  child: Text(
                  'You have not submitted any findings!',
                  textAlign: TextAlign.center,
                ))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                  itemBuilder: (BuildContext context, int i) {
                    return GestureDetector(
                        onTap: () => controller.onTapCard(i),
                        child: FindingsCard(
                          title: controller.myFindings[i].title,
                          description: controller.myFindings[i].equipmentDescription,
                          tag: controller.myFindings[i].equipmentTag,
                          category: controller.myFindings[i].category,
                          area: controller.myFindings[i].area,
                          date: controller.myFindings[i].date,
                          showStatus: true,
                          status: controller.getStatusFromInt(controller.myFindings[i].status),
                          onTapEdit: () => controller.onTapEdit(i),
                        ));
                  },
                  itemCount: controller.myFindings.length,
                ),
        ));
  }
}
