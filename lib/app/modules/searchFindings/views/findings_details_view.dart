import 'package:Findings/app/custom_widgets/widgets/finding_details_widget.dart';
import 'package:flutter/material.dart';

import '../../../custom_widgets/widgets/appBar.dart';

class FindingDetailsView extends StatelessWidget {
  const FindingDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'FINDING',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: FindingDetailsWidget()
      ),
    );
  }
}
