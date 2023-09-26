import 'package:Findings/app/custom_widgets/dialogs/submit_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/drop_down.dart';
import 'package:Findings/app/custom_widgets/widgets/findings_text_field.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            FindingsTextField(
              textEditingController: controller.titleController,
              title: 'Title',
              hint: 'Title of finding',
              maxLines: 1,
            ),
            Row(
              children: [
                Expanded(
                  child: DropDown(
                    dropDownList: controller.areaList,
                    value: controller.area,
                    hint: 'Select area',
                    title: 'Area',
                  ),
                ),
                Spacing.hMedium,
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: controller.date.value == ''
                            ? DateTime.now()
                            : DateFormat('MM/dd/y')
                            .parse(controller.date.value),
                        firstDate: DateTime(2023, 8),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != controller.date.value) {
                        controller.date.value =
                            DateFormat('MM/dd/y').format(picked).toString();
                      }
                    },
                    child: Obx(() =>
                        FindingsTextField(
                          textEditingController: TextEditingController(
                              text: controller.date.value),
                          title: 'Date',
                          hint: controller.date.value == ''
                              ? 'DD/MM/YYYY'
                              : controller.date.value,
                          maxLines: 1,
                          enabled: false,
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: DropDown(
                    dropDownList: controller.categoryList,
                    value: controller.category,
                    hint: 'Select Category',
                    title: 'Category',
                  ),
                ),
                Spacing.hMedium,
                Expanded(
                  child: FindingsTextField(
                    textEditingController: controller.equipmentTagController,
                    title: 'Equipment Tag',
                    hint: 'Tag',
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            FindingsTextField(
              textEditingController: controller.equipmentDescriptionController,
              title: 'Equipment Description',
              hint: 'Description of equipment',
            ),
            FindingsTextField(
              textEditingController: controller.problemController,
              title: 'Problem Statement',
              hint: 'Explain what happened?',
            ),
            FindingsTextField(
              textEditingController: controller.findingController,
              title: 'Key Finding',
              hint: 'Why it happened?',
            ),
            FindingsTextField(
              textEditingController: controller.solutionController,
              title: 'Solution',
              hint: 'How was it solved?',
            ),
            FindingsTextField(
              textEditingController: controller.preventionController,
              title: 'Prevention',
              hint: 'How to avoid it in future?',
            ),
            Row(
              children: [
                Expanded(
                  child: FindingsTextField(
                    textEditingController: controller.areaGlController,
                    title: 'Area GL',
                    hint: 'Area GL',
                    maxLines: 1,
                  ),
                ),
                Spacing.hMedium,
                Expanded(
                  child: FindingsTextField(
                    textEditingController: controller.createdByController,
                    title: 'Created By',
                    hint: 'Your name',
                    maxLines: 1,
                    enabled: false,
                  ),
                ),
              ],
            ),
            Spacing.vStandard,
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.onPressSubmit,
                style: ButtonStyle(
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            Spacing.vExtraLarge,

          ],
        ),
      ),
    );
  }
}
