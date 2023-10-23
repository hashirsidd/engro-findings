import 'package:Findings/app/routes/app_pages.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:Findings/app/custom_widgets/widgets/appBar.dart';
import 'package:Findings/app/modules/searchFindings/controllers/search_findings_controller.dart';
import 'package:Findings/app/custom_widgets/widgets/findings_card.dart';

class SearchFindingsView extends GetView<SearchFindingsController> {
  const SearchFindingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'SITE WIDE FINDINGS',
        action: Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 15),
          child: GestureDetector(
            child: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.black54,
            ),
            onTap: () {
              Get.toNamed(Routes.SEARCH_RESULT_FINDINGS);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          controller: controller.scrollController,
          children: [
            Obx(
              () => controller.pinnedFindings.isEmpty
                  ? const Center(
                      child: Text(
                        'No Pinned Findings',
                      ),
                    )
                  : Column(
                      children: [
                        Text(
                          "Pinned Findings",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Spacing.vLarge,
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            return GestureDetector(
                                onTap: () => controller.onTapCard(controller.pinnedFindings[i]),
                                child: FindingsCard(
                                  title: controller.pinnedFindings[i].title,
                                  description: controller.pinnedFindings[i].equipmentDescription,
                                  tag: controller.pinnedFindings[i].equipmentTag,
                                  category: controller.pinnedFindings[i].category,
                                  area: controller.pinnedFindings[i].area,
                                  date: controller.pinnedFindings[i].date,
                                ));
                          },
                          itemCount: controller.pinnedFindings.length,
                        ),
                      ],
                    ),
            ),
            Spacing.vStandard,
            const Divider(color: Colors.grey),
            Spacing.vStandard,
            Obx(
              () => controller.allFindings.isEmpty
                  ? const SizedBox()
                  : Column(
                      children: [
                        Text(
                          "All Findings",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Spacing.vLarge,
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            return GestureDetector(
                                onTap: () => controller.onTapCard(controller.allFindings[i]),
                                child: FindingsCard(
                                  title: controller.allFindings[i].title,
                                  description: controller.allFindings[i].equipmentDescription,
                                  tag: controller.allFindings[i].equipmentTag,
                                  category: controller.allFindings[i].category,
                                  area: controller.allFindings[i].area,
                                  date: controller.allFindings[i].date,
                                ));
                          },
                          itemCount: controller.allFindings.length,
                        ),
                        Obx(() => controller.isSearching.value
                            ? const SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                              )
                            : const SizedBox()),
                        Spacing.vLarge,
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
