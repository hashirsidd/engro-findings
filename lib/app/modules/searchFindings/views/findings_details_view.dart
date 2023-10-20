import 'package:Findings/app/custom_widgets/widgets/finding_details_widget.dart';
import 'package:Findings/app/data/findings_model.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:flutter/material.dart';

import '../../../custom_widgets/widgets/appBar.dart';

class FindingDetailsView extends StatelessWidget {
  final FindingsModel finding;
  final UserModel user;
  final Function reload;

  const FindingDetailsView({
    Key? key,
    required this.finding,
    required this.user,
    required this.reload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Container(
      //   padding: const EdgeInsets.all(14),
      //   decoration: BoxDecoration(
      //     boxShadow: const [
      //       BoxShadow(
      //         color: Colors.grey,
      //         offset: Offset(0.0, 1.0),
      //         blurRadius: 7.0,
      //       ),
      //     ],
      //     color: Colors.green,
      //     borderRadius: BorderRadius.circular(150),
      //   ),
      //   child: const Icon(
      //     Icons.download,
      //     color: Colors.white,
      //     size: 31,
      //   ),
      // ),
      appBar: const CustomAppBar(
        title: 'FINDING',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: FindingDetailsWidget(
          user: user,
          finding: finding,
          reload: reload,
        ),
      ),
    );
  }
}
