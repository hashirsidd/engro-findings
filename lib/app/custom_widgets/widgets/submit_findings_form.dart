import 'package:Findings/app/custom_widgets/widgets/image_viewer.dart';
import 'package:Findings/app/modules/home/controllers/home_controller.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../modules/fileFindings/controllers/file_findings_controller.dart';
import 'drop_down.dart';
import 'findings_text_field.dart';

class SubmitFindingsForm extends StatelessWidget {
  final FindingsController controller;

  SubmitFindingsForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  var categoryList = ['Machinery', 'Stationary'];
  var areaList = ['PM&S', 'URUT-I', 'UREA-II', 'URUT-III', 'AMM-II', 'AMM-III', 'Workshop'];
  HomeController homeController = Get.find();

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
                          colorScheme: const ColorScheme.light(
                            primary: Colors.green,
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                          dialogTheme: const DialogTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null && picked != controller.date.value) {
                    controller.date.value = DateFormat('MM/dd/y').format(picked).toString();
                  }
                },
                child: Obx(() => FindingsTextField(
                      textEditingController: TextEditingController(text: controller.date.value),
                      title: 'Date',
                      hint: controller.date.value == '' ? 'DD/MM/YYYY' : controller.date.value,
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
              child: Obx(
                () => FindingsTextField(
                  textEditingController: controller.createdByController,
                  title: 'Created By',
                  hint: homeController.user.value.email,
                  maxLines: 1,
                  enabled: false,
                ),
              ),
            ),
          ],
        ),
        Spacing.vStandard,
        const Text(
          "Upload Images",
          style: TextStyle(fontSize: 18),
        ),
        Spacing.vStandard,
        Container(
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 3.0,
                ),
              ],
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(10)),
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              Spacing.hStandard,
              Obx(() => controller.images.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Align(
                              child: Container(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => ImageViewer(
                                          images: controller.images,
                                          index: index,
                                        ));
                                  },
                                  child: controller.images[index] is String
                                      ? CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: controller.images[index],
                                          progressIndicatorBuilder:
                                              (context, url, downloadProgress) {
                                            if (downloadProgress == null) {
                                              return SizedBox();
                                            }
                                            return Center(
                                              child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    value: downloadProgress.totalSize != null
                                                        ? downloadProgress.totalSize! /
                                                            downloadProgress.downloaded
                                                        : null),
                                              ),
                                            );
                                          },
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                        )
                                      : Image.memory(
                                          controller.images[index],
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context, Object exception,
                                              StackTrace? stackTrace) {
                                            return const Center(child: Icon(Icons.broken_image));
                                          },
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              top: 3,
                              child: GestureDetector(
                                onTap: () {
                                  controller.removeImage(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(
                                    Icons.clear,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: controller.images.length,
                    )
                  : const SizedBox()),
              GestureDetector(
                onTap: () => controller.onTapUploadImage(),
                child: Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 3.0,
                      ),
                    ],
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.black54,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        Spacing.vLarge,
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
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
          ),
        ),
        Spacing.vExtraLarge,
      ],
    );
  }
}
