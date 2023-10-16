import 'package:Findings/app/custom_widgets/widgets/finding_details_widget.dart';
import 'package:Findings/app/data/findings_model.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Findings/app/custom_widgets/widgets/appBar.dart';

class FindingDetailView extends GetView {
  final FindingsModel finding;
  final UserModel user;

  const FindingDetailView({
    required this.finding,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'FINDING',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: FindingDetailsWidget(
          user: user,
          finding: finding,
        ),
      ),
    );
  }
}
