import 'package:Findings/app/custom_widgets/widgets/finding_details_widget.dart';
import 'package:flutter/material.dart';

import '../../../custom_widgets/widgets/appBar.dart';

class FindingDetailsView extends StatelessWidget {
  const FindingDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 7.0,
            ),
          ],
          color: Colors.green,
          borderRadius: BorderRadius.circular(150),
        ),
        child: const Icon(
          Icons.download,
          color: Colors.white,
          size: 31,
        ),
      ),
      appBar: CustomAppBar(
        title: 'FINDING',
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          // child: FindingDetailsWidget()
      ),
    );
  }
}
