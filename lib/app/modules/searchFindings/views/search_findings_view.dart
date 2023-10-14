import 'package:Findings/app/modules/searchFindings/views/findings_details_view.dart';
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
    controller.getFocus(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'SITE WIDE FINDINGS',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ListView(
            shrinkWrap: true,
            children: [
              SearchBar(
                elevation: MaterialStateProperty.all(5),
                focusNode: controller.searchFocus,
                hintText: "Search findings",
                hintStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(color: Colors.grey)),
                textStyle: MaterialStateProperty.all<TextStyle>(
                    Theme.of(context).textTheme.bodyMedium!),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                trailing: [
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Colors.black54,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Spacing.vExtraLarge,
              GestureDetector(
                  onTap: () {
                    Get.to(() => const FindingDetailsView());
                  },
                  child:   FindingsCard()),
              GestureDetector(
                  onTap: () {
                    Get.to(() => const FindingDetailsView());
                  },
                  child:   FindingsCard()),
            ],
          ),
        ),
      ),
    );
  }
}
