import 'package:Findings/app/modules/searchFindings/controllers/search_result_controller.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:Findings/app/custom_widgets/widgets/appBar.dart';
import 'package:Findings/app/custom_widgets/widgets/findings_card.dart';
import 'package:intl/intl.dart';

class SearchResultFindingsView extends GetView<SearchResultController> {
  SearchResultFindingsView({Key? key}) : super(key: key);
  var categoryList = ['MACHINERY', 'STATIONARY'];
  var areaList = ['PM&S', 'URUT-I', 'UREA-II', 'URUT-III', 'AMM-II', 'AMM-III', 'WORKSHOP'];

  @override
  Widget build(BuildContext context) {
    controller.getFocus(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'SEARCH FINDINGS',
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            children: [
              SearchBar(
                controller: controller.searchController,
                elevation: MaterialStateProperty.all(5),
                hintText: "Search findings",
                hintStyle:
                    MaterialStateProperty.all<TextStyle>(const TextStyle(color: Colors.grey)),
                textStyle:
                    MaterialStateProperty.all<TextStyle>(Theme.of(context).textTheme.bodyMedium!),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onSubmitted: (str) {
                  controller.searchFinding(context);

                  // controller.searchFocus.unfocus();
                  // FocusScope.of(context).unfocus();
                },
                trailing: [
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Colors.black54,
                    ),
                    onPressed: () => controller.searchFinding(context),
                  ),
                ],
              ),
              ExpansionTile(
                controller: controller.expansionTileController,
                title: const Text(
                  'Filters',
                  style: TextStyle(color: Colors.green),
                ),
                textColor: Colors.green,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Obx(() => DropdownButton(
                          value: controller.area.value == "" ? null : controller.area.value,
                          isExpanded: true,
                          hint: const Text(
                            'Select Area',
                            style: TextStyle(color: Colors.grey),
                          ),
                          underline: const SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          borderRadius: BorderRadius.circular(10),
                          items: areaList.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            if (newValue != null) controller.area.value = newValue;
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Obx(() => DropdownButton(
                          value: controller.category.value == "" ? null : controller.category.value,
                          isExpanded: true,
                          hint: const Text(
                            'Select Category',
                            style: TextStyle(color: Colors.grey),
                          ),
                          underline: const SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          borderRadius: BorderRadius.circular(10),
                          items: categoryList.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            if (newValue != null) controller.category.value = newValue;
                          },
                        )),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: controller.date.value == ''
                            ? DateTime.now()
                            : DateFormat('MM/dd/y').parse(controller.date.value),
                        firstDate: DateTime(2023, 8),
                        lastDate: controller.endDate.value != ''
                            ? DateFormat('MM/dd/y').parse(controller.endDate.value)
                            : DateTime.now(),
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
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 20),
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.date.value == '' ? 'From' : controller.date.value,
                                style: TextStyle(
                                    color:
                                        controller.date.value == '' ? Colors.grey : Colors.black87),
                                textAlign: TextAlign.left,
                              ),
                              Icon(
                                Icons.date_range_rounded,
                                color: controller.date.value == '' ? Colors.grey : Colors.black87,
                              )
                            ],
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: controller.endDate.value == ''
                            ? DateTime.now()
                            : DateFormat('MM/dd/y').parse(controller.endDate.value),
                        firstDate: controller.date.value != ''
                            ? DateFormat('MM/dd/y').parse(controller.date.value)
                            : DateTime(2023, 8),
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
                      if (picked != null && picked != controller.endDate.value) {
                        controller.endDate.value = DateFormat('MM/dd/y').format(picked).toString();
                      }
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 20),
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.endDate.value == '' ? 'To' : controller.endDate.value,
                                style: TextStyle(
                                    color: controller.endDate.value == ''
                                        ? Colors.grey
                                        : Colors.black87),
                                textAlign: TextAlign.left,
                              ),
                              Icon(
                                Icons.date_range_rounded,
                                color:
                                    controller.endDate.value == '' ? Colors.grey : Colors.black87,
                              )
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: controller.onTapClearFilters,
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
                        'Clear Filters',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Spacing.vLarge
                ],
              ),
              Spacing.vLarge,
              Obx(
                () => controller.isSearching.value
                    ? const Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        ),
                      )
                    : controller.searchedFindings.isEmpty
                        ? const Center(
                            child: Text(
                              'No Findings',
                            ),
                          )
                        : Column(
                            children: [
                              Text(
                                "Search Result",
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
                                      onTap: () =>
                                          controller.onTapCard(controller.searchedFindings[i]),
                                      child: FindingsCard(
                                        title: controller.searchedFindings[i].title,
                                        description:
                                            controller.searchedFindings[i].equipmentDescription,
                                        tag: controller.searchedFindings[i].equipmentTag,
                                        category: controller.searchedFindings[i].category,
                                        area: controller.searchedFindings[i].area,
                                        date: controller.searchedFindings[i].date,
                                      ));
                                },
                                itemCount: controller.searchedFindings.length,
                              ),
                            ],
                          ),
              ),
              Spacing.vStandard,
            ],
          ),
        ),
      ),
    );
  }
}
