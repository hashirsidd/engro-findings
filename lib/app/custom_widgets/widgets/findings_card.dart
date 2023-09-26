import 'package:Findings/app/routes/app_pages.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../modules/submittedFindings/views/edit_submitted_findings_view.dart';

enum Status {
  inReview,
  rejected,
  accepted,
}

class FindingsCard extends StatelessWidget {
  final Status status;
  final bool showStatus;

  const FindingsCard({
    Key? key,
    this.showStatus = false,
    this.status = Status.accepted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0),
            blurRadius: 7.0,
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Engro Maintenance Report',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              Text(
                '31/6/23',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
          Spacing.vStandard,
          const Text(
            "The preliminary analysis of our sales data for this quarter shows promising growth in our key markets. We've seen a 12% increase in revenue compared to the same period last year.",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black54),
          ),
          Spacing.vExtraLarge,
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(87, 130, 243, 1.0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    'AS-01',
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spacing.hStandard,
              Expanded(
                child: Container(
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    'Workshop',
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spacing.hStandard,
              Expanded(
                child: Container(
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(3, 155, 16, 1.0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    'Stationary',
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          if (showStatus) ...[
            Spacing.vLarge,
            Row(
              children: [
                const Text(
                  'Status :',
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  ' ${status.name.toUpperCase()}',
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: status == Status.accepted
                        ? Colors.green
                        : status == Status.rejected
                            ? Colors.red
                            : Colors.black45,
                  ),
                ),
                const Spacer(),
                if (status == Status.inReview)
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.EDIT_SUBMITTED_FINDINGS),
                    child: const Icon(
                      Icons.edit_outlined,
                    ),
                  )
              ],
            ),
          ]
        ],
      ),
    );
  }
}
