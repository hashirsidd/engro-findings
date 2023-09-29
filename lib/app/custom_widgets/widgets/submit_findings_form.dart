import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../modules/fileFindings/controllers/file_findings_controller.dart';
import 'drop_down.dart';
import 'findings_text_field.dart';

class SubmitFindingsForm extends StatelessWidget {
  final controller;

  SubmitFindingsForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  var categoryList = ['Machinery', 'Stationary'];
  var areaList = ['PM&S', 'URUT-I', 'UREA-II', 'URUT-III', 'AMM-II', 'AMM-III'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        FindingsTextField(
          textEditingController: controller.titleController,
          title: 'Title',
          hint: 'Title of finding',
          maxLines: 1,
          nextFocus: controller.equipmentTagFocus,
        ),
        Row(
          children: [
            Expanded(
              child: DropDown(
                dropDownList: areaList,
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
                        : DateFormat('MM/dd/y').parse(controller.date.value),
                    firstDate: DateTime(2023, 8),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.green, // <-- SEE HERE
                            onPrimary: Colors.white, // <-- SEE HERE
                            onSurface: Colors.black, // <-- SEE HERE
                          ),
                          dialogTheme: const DialogTheme(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(16)))),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null && picked != controller.date.value) {
                    controller.date.value =
                        DateFormat('MM/dd/y').format(picked).toString();
                  }
                },
                child: Obx(() => FindingsTextField(
                      textEditingController:
                          TextEditingController(text: controller.date.value),
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
                dropDownList: categoryList,
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
                currentFocus: controller.equipmentTagFocus,
                nextFocus: controller.equipmentDescriptionFocus,
                maxLines: 1,
              ),
            ),
          ],
        ),
        FindingsTextField(
          textEditingController: controller.equipmentDescriptionController,
          title: 'Equipment Description',
          hint: 'Description of equipment',
          currentFocus: controller.equipmentDescriptionFocus,
          nextFocus: controller.problemFocus,
        ),
        FindingsTextField(
          textEditingController: controller.problemController,
          title: 'Problem Statement',
          hint: 'Explain what happened?',
          currentFocus: controller.problemFocus,
          nextFocus: controller.findingFocus,
        ),
        FindingsTextField(
          textEditingController: controller.findingController,
          title: 'Key Finding',
          hint: 'Why it happened?',
          currentFocus: controller.findingFocus,
          nextFocus: controller.solutionFocus,
        ),
        FindingsTextField(
          textEditingController: controller.solutionController,
          title: 'Solution',
          hint: 'How was it solved?',
          currentFocus: controller.solutionFocus,
          nextFocus: controller.preventionFocus,
        ),
        FindingsTextField(
          textEditingController: controller.preventionController,
          title: 'Prevention',
          hint: 'How to avoid it in future?',
          currentFocus: controller.preventionFocus,
          nextFocus: controller.areaGlFocus,
        ),
        Row(
          children: [
            Expanded(
              child: FindingsTextField(
                textEditingController: controller.areaGlController,
                title: 'Area GL',
                hint: 'Area GL',
                maxLines: 1,
                currentFocus: controller.areaGlFocus,
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
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: Text(
              controller.buttonText,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
        Spacing.vExtraLarge,
      ],
    );
  }
}
