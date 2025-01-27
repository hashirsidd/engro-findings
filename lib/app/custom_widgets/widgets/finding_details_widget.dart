import 'package:Findings/app/custom_widgets/widgets/image_viewer.dart';
import 'package:Findings/app/data/findings_model.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/modules/home/controllers/home_controller.dart';
import 'package:Findings/app/utils/extension.dart';
import 'package:Findings/app/utils/helper_functions.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FindingDetailsWidget extends StatelessWidget {
  final FindingsModel finding;
  final UserModel user;
  final Function reload;
  final HomeController homeController = Get.find();

  FindingDetailsWidget({
    Key? key,
    required this.finding,
    required this.user,
    required this.reload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                clipBehavior: Clip.hardEdge,
                child: user.profilePictureUrl != ""
                    ? CachedNetworkImage(
                        imageUrl: user.profilePictureUrl,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/user.png',
                      ),
              ),
              Spacing.hStandard,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      user.area,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      finding.date,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Spacing.vStandard,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          HelperFunctions.shareFinding(finding.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: const Icon(
                            Icons.share,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          HelperFunctions.downloadFinding(finding.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: const Icon(
                            Icons.save_alt,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      if ((homeController.user.value.isAdmin && finding.status == 1)) ...[
                        GestureDetector(
                          onTap: () {
                            HelperFunctions.pinFinding(finding.id, reload, finding.pinned);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: const Icon(
                              Icons.add_chart_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                      if ((homeController.user.value.isAdmin) ||
                          (user.uid == finding.createdByUid && finding.status != 1)) ...[
                        GestureDetector(
                          onTap: () {
                            HelperFunctions.deleteFindingDialog(finding.id, reload);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Spacing.vSmall,
              Column(
                children: [
                  Center(
                    child: Text(
                      finding.title.toSentenceCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),
                    ),
                  ),
                ],
              ),
              Spacing.vExtraLarge,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(87, 130, 243, 1.0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          finding.equipmentTag.toUpperCase(),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacing.hStandard,
                  Expanded(
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          finding.area.toUpperCase(),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacing.hStandard,
                  Expanded(
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(3, 155, 16, 1.0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          finding.category.toUpperCase(),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Spacing.vExtraLarge,
              const Text(
                'Equipment Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              Spacing.vStandard,
              Text(
                finding.equipmentDescription.toSentenceCase(),
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Text(
                'Problem Statement: What happened?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              Spacing.vStandard,
              Text(
                finding.problem.toSentenceCase(),
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Text(
                'Key Findings: Why it happened?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              Spacing.vStandard,
              Text(
                finding.finding.toSentenceCase(),
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Text(
                'Solution: How was it rectified?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              Spacing.vStandard,
              Text(
                finding.solution.toSentenceCase(),
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Text(
                'Prevention: How to avoid it in future?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              Spacing.vStandard,
              Text(
                finding.prevention.toSentenceCase(),
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Area GL',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
                        ),
                        Spacing.vStandard,
                        Text(
                          finding.areaGl,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Spacing.hStandard,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Created by',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
                        ),
                        Spacing.vStandard,
                        Text(
                          user.email,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacing.vExtraLarge,
              finding.images.isNotEmpty
                  ? Container(
                      height: 80,
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              width: 80,
                              height: 80,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black38),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => ImageViewer(
                                        images: finding.images,
                                        index: index,
                                      ));
                                },
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: finding.images[index],
                                  progressIndicatorBuilder: (context, url, downloadProgress) {
                                    if (downloadProgress == null) {
                                      return const SizedBox();
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
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ));
                        },
                        itemCount: finding.images.length,
                      ))
                  : const SizedBox(),
              Spacing.vLarge,
            ],
          ),
        ),
      ],
    );
  }
}
