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
  final String title;
  final String description;
  final String date;
  final String area;
  final String tag;
  final String category;

  FindingsCard({
    Key? key,
    this.showStatus = false,
    this.status = Status.accepted,
    this.title = "",
    this.description = '',
    this.date = '',
    this.area = '',
    this.tag = '',
    this.category = '',
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  softWrap: false,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
              ),
              Spacing.hLarge,
              Text(
                date,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
          Spacing.vStandard,
          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
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
                  child: Text(
                    tag.toUpperCase(),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: const TextStyle(
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
                  child: Text(
                    area,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: const TextStyle(
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
                  child: Text(
                    category,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: const TextStyle(
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
