import 'dart:io';
import 'dart:typed_data';
import 'package:Findings/app/custom_widgets/dialogs/submit_dialog.dart';
import 'package:Findings/main.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:Findings/app/custom_widgets/dialogs/loading_dialog.dart';
import 'package:Findings/app/custom_widgets/widgets/customSnackbar.dart';
import 'package:Findings/app/data/findings_model.dart';
import 'package:Findings/app/data/user_model.dart';
import 'package:Findings/app/utils/extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';

import 'package:pdf/widgets.dart' as pw;

class HelperFunctions {
  static downloadAllData() async {
    int notificationId = DateTime.now().millisecond;
    try {
      Get.back();
      Get.dialog(const LoadingDialog());
      localNotificationService.showNotificationAndroid(
        title: "Download started",
        value: "CSV downloading",
        channelId: 'csv_download',
        channelName: 'csv_download',
        notificationId: notificationId,
        payload: '',
      );
      bool hasMoreData = true;
      List<List<dynamic>> rows = [];
      rows.add([
        "id",
        "created by",
        "title",
        'area',
        'date',
        'category',
        'equipment tag',
        'equipment description',
        'problem',
        'finding',
        'solution',
        'prevention',
        'images',
        'area GL'
      ]);
      QuerySnapshot<Map<String, dynamic>> findingsData = await FirebaseFirestore.instance
          .collection('findings')
          .where('isApproved', isEqualTo: 1)
          .orderBy('timeStamp', descending: true)
          .limit(50)
          .get();
      if (findingsData.docs.isNotEmpty) {
        for (var element in findingsData.docs) {
          FindingsModel finding = FindingsModel.fromJson(element.data());
          rows.add([
            finding.id,
            finding.createdByEmail,
            finding.title,
            finding.area,
            finding.date,
            finding.category,
            finding.equipmentTag,
            finding.equipmentDescription,
            finding.problem,
            finding.finding,
            finding.solution,
            finding.prevention,
            finding.images,
            finding.areaGl
          ]);
        }
      }
      if (findingsData.docs.length < 50) {
        hasMoreData = false;
      }
      while (hasMoreData) {
        QuerySnapshot<Map<String, dynamic>> addFindingsData = await FirebaseFirestore.instance
            .collection('findings')
            .where('isApproved', isEqualTo: 1)
            .orderBy('timeStamp', descending: true)
            .startAfterDocument(findingsData.docs.last)
            .limit(50)
            .get();
        findingsData = addFindingsData;
        if (findingsData.docs.isNotEmpty) {
          for (var element in findingsData.docs) {
            FindingsModel finding = FindingsModel.fromJson(element.data());
            rows.add([
              finding.id,
              finding.createdByEmail,
              finding.title,
              finding.area,
              finding.date,
              finding.category,
              finding.equipmentTag,
              finding.equipmentDescription,
              finding.problem,
              finding.finding,
              finding.solution,
              finding.prevention,
              finding.images,
              finding.areaGl
            ]);
          }
        } else {
          hasMoreData = false;
        }
      }
      String path = '/storage/emulated/0/Download/${DateTime.now().millisecond}_all_findings.csv';
      File file = File(path);
      String csv = const ListToCsvConverter().convert(rows);
      await file.writeAsString(csv);
      print("File exported successfully!");
      Get.back();
      await localNotificationService.flutterLocalNotificationsPlugin.cancel(notificationId);
      localNotificationService.showNotificationAndroid(
        title: "Finding pdf",
        value: "CSV downloaded",
        channelId: 'csv_download',
        channelName: 'csv_download',
        notificationId: notificationId,
        payload: path,
      );
    } catch (e) {
      print(e);
      Get.back();
      await localNotificationService.flutterLocalNotificationsPlugin.cancel(notificationId);
      CustomGetxWidgets.CustomSnackbar('Error', 'Pleases try again!', color: Colors.red);
    }
  }

  static Future<pw.Document> createPdf(FindingsModel finding) async {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await FirebaseFirestore.instance.collection('users').doc(finding.createdByUid).get();
    UserModel user = UserModel.fromJson(userData.data()!);
    List<pw.Widget> images = [];
    for (String image in finding.images) {
      Uint8List bytes =
          (await NetworkAssetBundle(Uri.parse(image)).load(image)).buffer.asUint8List();
      images.add(pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Image(pw.MemoryImage(bytes), height: 200)));
    }

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          build: (pw.Context context) {
            return [
              pw.Wrap(
                children: [
                  pw.Align(
                    alignment: pw.Alignment.topRight,
                    child: pw.Text(
                      finding.date,
                      style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColor.fromHex('#9E9E9E'),
                          fontStyle: pw.FontStyle.italic),
                    ),
                  ),
                  pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                    pw.Center(
                      child: pw.Text(
                        finding.title.toSentenceCase(),
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#000000')),
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            height: 30,
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex("#5783f3"),
                              borderRadius: pw.BorderRadius.circular(5),
                            ),
                            child: pw.FittedBox(
                              fit: pw.BoxFit.scaleDown,
                              child: pw.Text(
                                finding.equipmentTag.toUpperCase(),
                                overflow: pw.TextOverflow.clip,
                                maxLines: 1,
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColor.fromHex("#FFFFFF"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        pw.SizedBox(width: 20),
                        pw.Expanded(
                          child: pw.Container(
                            height: 30,
                            padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                            alignment: pw.Alignment.center,
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex('#FFAB40'),
                              borderRadius: pw.BorderRadius.circular(5),
                            ),
                            child: pw.FittedBox(
                              fit: pw.BoxFit.scaleDown,
                              child: pw.Text(
                                finding.area.toUpperCase(),
                                overflow: pw.TextOverflow.clip,
                                maxLines: 1,
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColor.fromHex('#FFFFFF'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        pw.SizedBox(width: 20),
                        pw.Expanded(
                          child: pw.Container(
                            height: 30,
                            padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                            alignment: pw.Alignment.center,
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex('#039B10'),
                              borderRadius: pw.BorderRadius.circular(5),
                            ),
                            child: pw.FittedBox(
                              fit: pw.BoxFit.scaleDown,
                              child: pw.Text(
                                finding.category.toUpperCase(),
                                overflow: pw.TextOverflow.clip,
                                maxLines: 1,
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColor.fromHex('#FFFFFF'),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 10),
                    child: pw.RichText(
                      text: pw.TextSpan(
                        text: 'Equipment Description\n',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        children: [
                          pw.TextSpan(
                            text: finding.equipmentDescription.toSentenceCase(),
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 10),
                    child: pw.RichText(
                      text: pw.TextSpan(
                        text: 'Problem Statement: What happened?\n',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        children: [
                          pw.TextSpan(
                            text: finding.problem.toSentenceCase(),
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 10),
                    child: pw.RichText(
                      text: pw.TextSpan(
                        text: 'Key Findings: Why it happened?\n',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        children: [
                          pw.TextSpan(
                            text: finding.finding.toSentenceCase(),
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 10),
                    child: pw.RichText(
                      text: pw.TextSpan(
                        text: 'Solution: How was it rectified?\n',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        children: [
                          pw.TextSpan(
                            text: finding.solution.toSentenceCase(),
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 10),
                    child: pw.RichText(
                      text: pw.TextSpan(
                        text: 'Prevention: How to avoid it in future?\n',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        children: [
                          pw.TextSpan(
                            text: finding.prevention.toSentenceCase(),
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 20),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                'Area GL',
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                finding.areaGl,
                                style: const pw.TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                'Created by',
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                user.email,
                                style: const pw.TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...images,
                ],
              )
            ];
          }),
    );

    return pdf;
  }

  static downloadFinding(String id) async {
    try {
      int notificationId = DateTime.now().millisecond;
      localNotificationService.showNotificationAndroid(
        title: "Download started",
        value: "PDF downloading",
        channelId: 'pdf_download',
        channelName: 'pdf_download',
        notificationId: notificationId,
        payload: '',
      );
      DocumentSnapshot<Map<String, dynamic>> findingData =
          await FirebaseFirestore.instance.collection('findings').doc(id).get();

      if (findingData.data() != null) {
        Get.dialog(const LoadingDialog());
        FindingsModel finding = FindingsModel.fromJson(findingData.data()!);
        final pdf = await createPdf(finding);
        final Directory? appDocumentsDir = await getTemporaryDirectory();
        if (appDocumentsDir != null) {}
        File file = File('/storage/emulated/0/Download/${finding.id}.pdf');
        await file.writeAsBytes(await pdf.save(), mode: FileMode.write);
        String path = '/storage/emulated/0/Download/${finding.id}.pdf';
        // Share.shareFiles([file.path]);
        Get.back();
        await localNotificationService.flutterLocalNotificationsPlugin.cancel(notificationId);
        localNotificationService.showNotificationAndroid(
          title: "Finding pdf",
          value: "PDF downloaded",
          channelId: finding.id,
          channelName: 'pdf_download',
          notificationId: notificationId,
          payload: path,
        );
        await OpenFilex.open(path);
        // await launchUrl(Uri.parse(path));
      }
    } catch (e) {
      print(e);
      Get.back();
      CustomGetxWidgets.CustomSnackbar('Error', 'Pleases try again!', color: Colors.red);
    }
  }

  static shareFinding(String id) async {
    try {
      Get.dialog(const LoadingDialog());
      DocumentSnapshot<Map<String, dynamic>> findingData =
          await FirebaseFirestore.instance.collection('findings').doc(id).get();
      if (findingData.data() != null) {
        FindingsModel finding = FindingsModel.fromJson(findingData.data()!);
        final pdf = await createPdf(finding);
        final Directory? appDocumentsDir = await getTemporaryDirectory();
        if (appDocumentsDir != null) {}
        String path = appDocumentsDir!.path + '/${finding.id}.pdf';
        File file = File(path);
        await file.writeAsBytes(await pdf.save(), mode: FileMode.write);
        Get.back();
        Share.shareXFiles([XFile(file.path)]);
        // await launchUrl(Uri.parse(path));
      }
    } catch (e) {
      print(e);
      Get.back();
      CustomGetxWidgets.CustomSnackbar('Error', 'Pleases try again!', color: Colors.red);
    }
  }

  static pinFinding(String id, Function reload, bool pinned) async {
    Get.dialog(
      SubmitDialog(
        titleIcon: const Icon(Icons.add_chart, color: Colors.green, size: 100),
        title: '${pinned ? "Unpin" : 'Pin'} finding',
        description: 'This finding will be ${pinned ? "unpinned" : 'pinned'}!',
        rightButtonText: pinned ? "Unpin" : 'Pin',
        leftButtonText: 'Cancel',
        rightButtonOnTap: () async {
          Get.back();
          Get.dialog(const LoadingDialog());
          bool hasException = false;
          try {
            DocumentSnapshot<Map<String, dynamic>> finding =
                await FirebaseFirestore.instance.collection('findings').doc(id).get();
            if (finding.data() != null) {
              FindingsModel findingsModel = FindingsModel.fromJson(finding.data()!);
              await FirebaseFirestore.instance
                  .collection('findings')
                  .doc(id)
                  .set({'pinned': !findingsModel.pinned}, SetOptions(merge: true));
            }
          } catch (e) {
            print(e);
            hasException = true;
          } finally {
            Get.back();
            if (hasException) {
              Get.back();
              CustomGetxWidgets.CustomSnackbar('Error', 'Pleases try again!', color: Colors.red);
            } else {
              await reload();
              CustomGetxWidgets.CustomSnackbar(
                  'Success', 'Finding has been ${pinned ? "unpinned" : 'pinned'}');
            }
          }
        },
        leftButtonOnTap: () => Get.back(),
      ),
    );
  }

  static deleteFinding(String id, Function reload) async {
    Get.dialog(const LoadingDialog());
    bool hasException = false;
    try {
      DocumentSnapshot<Map<String, dynamic>> finding =
          await FirebaseFirestore.instance.collection('findings').doc(id).get();
      if (finding.data() != null) {
        FindingsModel findingsModel = FindingsModel.fromJson(finding.data()!);
        await FirebaseFirestore.instance.collection('overview').doc('graph').set({
          "${findingsModel.area.toLowerCase()} ${findingsModel.category.toLowerCase()}":
              FieldValue.increment(-1)
        }, SetOptions(merge: true));
      }
      await FirebaseFirestore.instance.collection('findings').doc(id).delete();
    } catch (e) {
      print(e);
      hasException = true;
    } finally {
      Get.back();
      if (hasException) {
        CustomGetxWidgets.CustomSnackbar('Error', 'Pleases try again!', color: Colors.red);
      } else {
        await reload();
        Get.back();
        CustomGetxWidgets.CustomSnackbar('Success', 'Finding has been deleted');
      }
    }
  }

  static deleteFindingDialog(String id, Function reload) {
    Get.dialog(
      SubmitDialog(
        titleIcon: const Icon(Icons.delete, color: Colors.red, size: 100),
        title: 'Delete finding',
        description: 'This finding will be deleted permanently!',
        rightButtonText: 'Delete',
        leftButtonText: 'Cancel',
        rightButtonOnTap: () {
          Get.back();
          deleteFinding(id, reload);
        },
        leftButtonOnTap: () => Get.back(),
        titleTextColor: Colors.red,
      ),
    );
  }
}
