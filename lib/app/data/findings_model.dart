// To parse this JSON data, do
//
//     final findingsModel = findingsModelFromJson(jsonString);

import 'dart:convert';

FindingsModel findingsModelFromJson(String str) => FindingsModel.fromJson(json.decode(str));

String findingsModelToJson(FindingsModel data) => json.encode(data.toJson());

class FindingsModel {
  String title;
  String area;
  String date;
  String category;
  String equipmentTag;
  String equipmentDescription;
  String problem;
  String finding;
  String solution;
  String prevention;
  List images;
  bool isApproved;
  String createdByEmail;
  String createdByUid;

  FindingsModel({
    required this.title,
    required this.area,
    required this.date,
    required this.category,
    required this.equipmentTag,
    required this.equipmentDescription,
    required this.problem,
    required this.finding,
    required this.solution,
    required this.prevention,
    required this.images,
    required this.isApproved,
    required this.createdByEmail,
    required this.createdByUid,
  });

  factory FindingsModel.fromJson(Map<String, dynamic> json) => FindingsModel(
        title: json["title"],
        area: json["area"],
        date: json["date"],
        category: json["category"],
        equipmentTag: json["equipmentTag"],
        equipmentDescription: json["equipmentDescription"],
        problem: json["problem"],
        finding: json["finding"],
        solution: json["solution"],
        prevention: json["prevention"],
        images: List.from(json["images"].map((x) => x)),
        isApproved: json["isApproved"],
        createdByEmail: json["createdByEmail"],
        createdByUid: json["createdByUid"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "area": area,
        "date": date,
        "category": category,
        "equipmentTag": equipmentTag,
        "equipmentDescription": equipmentDescription,
        "problem": problem,
        "finding": finding,
        "solution": solution,
        "prevention": prevention,
        "images": List<dynamic>.from(images.map((x) => x)),
        "isApproved": isApproved,
        "createdByEmail": createdByEmail,
        "createdByUid": createdByUid,
      };
}
