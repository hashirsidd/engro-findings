import 'package:Findings/app/data/findings_model.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/utils/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FindingDetailsWidget extends StatelessWidget {
  final FindingsModel finding;
  final UserModel user;

  FindingDetailsWidget({
    Key? key,
    required this.finding,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                clipBehavior: Clip.hardEdge,
                child: user.profilePictureUrl != ""
                    ? CachedNetworkImage(
                        imageUrl: user.profilePictureUrl,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/user.png',
                      ),
              ),
              Spacing.hStandard,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    user.area,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                finding.date,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Spacing.vSmall,
              Center(
                child: Text(
                  finding.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
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
                        finding.equipmentTag.toUpperCase(),
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
                        finding.area,
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
                        finding.category,
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
              Spacing.vExtraLarge,
              const Text(
                'Equipment Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              Spacing.vStandard,
              Text(
                finding.equipmentDescription,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Text(
                'Problem Statement: What happened?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              Spacing.vStandard,
              Text(
                finding.problem,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Text(
                'Key Findings: Why it happened?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              Spacing.vStandard,
              Text(
                finding.finding,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Text(
                'Solution: How was it rectified?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              Spacing.vStandard,
              Text(
                finding.solution,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              const Text(
                'Prevention: How to avoid it in future?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              Spacing.vStandard,
              Text(
                finding.prevention,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
              ),
              Spacing.vExtraLarge,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Area GL',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
                        ),
                        Spacing.vStandard,
                        Text(
                          finding.areaGl,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Spacing.hStandard,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Created by',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
                        ),
                        Spacing.vStandard,
                        Text(
                          user.email,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
