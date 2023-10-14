import 'package:Findings/app/custom_widgets/widgets/finding_details_widget.dart';
import 'package:Findings/app/data/findings_model.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Findings/app/custom_widgets/widgets/appBar.dart';

class ApproveRejectFindingView extends GetView {
  final FindingsModel finding;
  final UserModel user;
  final Function onTapApprove;
  final Function onTapReject;

  const ApproveRejectFindingView({
    required this.finding,
    required this.user,
    required this.onTapApprove,
    required this.onTapReject,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'FINDINGS',
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: FindingDetailsWidget(
              user: user,
              finding: finding,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => onTapReject(),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: Text(
                          'Reject',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Spacing.hStandard,
                  Expanded(
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => onTapApprove(),
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
                          'Approve',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Spacing.hStandard,
                  Expanded(
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: Text(
                          'Edit',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
