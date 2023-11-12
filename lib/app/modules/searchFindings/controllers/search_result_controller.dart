import 'dart:ffi';

import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/custom_widgets/widgets/findings_detail_view.dart';
import 'package:Findings/app/utils/extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/dialogs/loading_dialog.dart';
import '../../../data/findings_model.dart';
import '../../../data/user_model.dart';
import 'package:intl/intl.dart';

class SearchResultController extends GetxController {
  FocusNode searchFocus = FocusNode();
  TextEditingController searchController = TextEditingController();
  RxList<FindingsModel> searchedFindings = <FindingsModel>[].obs;
  RxBool isSearching = false.obs;
  RxString area = ''.obs;
  RxString category = ''.obs;
  RxString date = ''.obs;
  RxString endDate = ''.obs;
  Map<String, dynamic> ids = {};

  ExpansionTileController expansionTileController = ExpansionTileController();

  getFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(searchFocus);
  }

  searchFinding(BuildContext context) async {
    if (!(isSearching.value) &&
        (searchController.text.trim().isNotEmpty ||
            area.value.isNotEmpty ||
            category.value.isNotEmpty ||
            date.value.isNotEmpty ||
            date.value.isNotEmpty)) {
      FocusScope.of(context).requestFocus(FocusNode());
      isSearching.value = true;
      expansionTileController.collapse();
      searchedFindings.clear();
      ids.clear();
      String input = searchController.text.trim().toLowerCase();
      var collectionReference = FirebaseFirestore.instance.collection('findings');

      List<DocumentSnapshot> results = [];

      List<Query> queries = [
        collectionReference.where('titleList', arrayContainsAny: input.toListOfWords()),
        collectionReference.where('equipmentTag', isEqualTo: input),
        collectionReference.where('equipmentDescList', arrayContainsAny: input.toListOfWords()),
      ];
      if (area.value.isNotEmpty) {
        queries.add(
          collectionReference.where('area', isEqualTo: area.value),
        );
      }
      if (category.value.isNotEmpty) {
        queries.add(
          collectionReference.where('category', isEqualTo: category.value),
        );
      }

      for (var query in queries) {
        try {
          QuerySnapshot querySnapshot = await query.get();
          results.addAll(querySnapshot.docs);
        } catch (e) {
          print("Error executing query: $e");
        }
      }
      try {
        isSearching.value = false;
        results.forEach((element) {
          FindingsModel findingsModel =
              FindingsModel.fromJson(element.data() as Map<String, dynamic>);
          if (ids[findingsModel.id] == null) {
            ids[findingsModel.id] = '';
            if (date.value == '' && endDate.value == '') {
              searchedFindings.add(findingsModel);
            } else if (date.value != '' && endDate.value == '') {
              if (DateFormat('MM/dd/y')
                      .parse(findingsModel.date)
                      .isAtSameMomentAs(DateFormat('MM/dd/y').parse(date.value)) ||
                  DateFormat('MM/dd/y')
                      .parse(findingsModel.date)
                      .isAfter(DateFormat('MM/dd/y').parse(date.value))) {
                searchedFindings.add(findingsModel);
              }
            } else if (date.value == '' && endDate.value != '') {
              if (DateFormat('MM/dd/y')
                      .parse(findingsModel.date)
                      .isAtSameMomentAs(DateFormat('MM/dd/y').parse(endDate.value)) ||
                  DateFormat('MM/dd/y')
                      .parse(findingsModel.date)
                      .isBefore(DateFormat('MM/dd/y').parse(endDate.value))) {
                searchedFindings.add(findingsModel);
              }
            } else if (date.value != '' && endDate.value != '') {
              if ((DateFormat('MM/dd/y')
                          .parse(findingsModel.date)
                          .isAtSameMomentAs(DateFormat('MM/dd/y').parse(endDate.value)) ||
                      DateFormat('MM/dd/y')
                          .parse(findingsModel.date)
                          .isBefore(DateFormat('MM/dd/y').parse(endDate.value))) &&
                  (DateFormat('MM/dd/y')
                          .parse(findingsModel.date)
                          .isAtSameMomentAs(DateFormat('MM/dd/y').parse(date.value)) ||
                      DateFormat('MM/dd/y')
                          .parse(findingsModel.date)
                          .isAfter(DateFormat('MM/dd/y').parse(date.value)))) {
                searchedFindings.add(findingsModel);
              }
            }
          }
        });
      } catch (e) {
        print(e);
      }
      isSearching.value = false;
    }
  }

  onTapClearFilters() {
    area.value = '';
    category.value = '';
    date.value = '';
  }

  Future<UserModel?> getUserDetails(String uid) async {
    UserModel? user;
    Get.dialog(const LoadingDialog(), barrierDismissible: false);
    try {
      var value = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (value.data() != null) {
        user = UserModel.fromJson(value.data()!);
      } else {
        throw 'User not found';
      }
      Get.back();
    } catch (e) {
      Get.back();
      CustomGetxWidgets.CustomSnackbar("Error", "Unable to get user data!", color: Colors.red);
    }
    return user;
  }

  onTapCard(FindingsModel finding) async {
    UserModel? user = await getUserDetails(finding.createdByUid);
    if (user != null) {
      Get.to(() => FindingDetailView(
            user: user,
            finding: finding,
            reload: () {},
          ));
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    getFocus(Get.context!);
  }
}
