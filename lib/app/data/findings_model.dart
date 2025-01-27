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
  int status; // 0 = rejected,1 = accepted,2 = inreview
  String createdByEmail;
  String createdByUid;
  String areaGl;
  String id;
  bool pinned;
  dynamic timeStamp;

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
    required this.status,
    required this.createdByEmail,
    required this.createdByUid,
    required this.timeStamp,
    required this.areaGl,
    required this.id,
    required this.pinned,
  });

  factory FindingsModel.fromJson(Map<String, dynamic> json) => FindingsModel(
        title: json["title"],
        area: json["area"].toUpperCase(),
        date: json["date"],
        category: json["category"].toUpperCase(),
        equipmentTag: json["equipmentTag"],
        equipmentDescription: json["equipmentDescription"],
        problem: json["problem"],
        finding: json["finding"],
        solution: json["solution"],
        prevention: json["prevention"],
        images: List.from(json["images"].map((x) => x)),
        status: json["isApproved"],
        createdByEmail: json["createdByEmail"],
        createdByUid: json["createdByUid"],
        timeStamp: json["timeStamp"],
        areaGl: json["areaGl"],
        id: json["id"],
        pinned: json["pinned"],
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
        "isApproved": status,
        "createdByEmail": createdByEmail,
        "createdByUid": createdByUid,
        "timeStamp": timeStamp,
        "areaGl": areaGl,
        'id': id,
        'pinned': pinned,
      };
}
