import 'dart:async';
import 'dart:convert';

import 'package:Findings/app/custom_widgets/dialogs/notification_dialog.dart';
import 'package:Findings/app/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: backgroundSelectNotification,
      onDidReceiveNotificationResponse: selectNotification,
    );
  }

  void showNotificationAndroid(
      {required String title,
      required String value,
      required String channelId,
      required String channelName,
      required String payload,
      required int notificationId}) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: 'Channel Description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(notificationId, title, value, notificationDetails,
        payload: payload);
  }
}

@pragma('vm:entry-point')
Future backgroundSelectNotification(NotificationResponse payload) async {
  handleSelectNotification(payload.payload);
}

Future selectNotification(NotificationResponse payload) async {
  handleSelectNotification(payload.payload);
}

handleSelectNotification(String? data) async {
  if (data != null && data.contains('.pdf')) {
    await OpenFilex.open(data);
  } else {
    Map notificationData = json.decode(data ?? '');
    await Get.dialog(NotificationDialog(
      title: notificationData['title'],
      description: notificationData['description'],
    ));
  }
}

LocalNotificationService localNotificationService = LocalNotificationService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();
  await localNotificationService.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  FirebaseMessaging.onBackgroundMessage(_handleMessage);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _handleMessage(message);
  });
  runApp(
    GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: AppTheme.lightTheme(),
        debugShowCheckedModeBanner: false,
        routingCallback: (value) {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
              statusBarColor: Color.fromRGBO(250, 250, 250, 1),
              statusBarIconBrightness: Brightness.dark));
        }),
  );
}

Future<void> _handleMessage(RemoteMessage message)async {
  Map<String, dynamic> data = message.data;
  localNotificationService.showNotificationAndroid(
    title: data['title'],
    value: data['description'],
    channelId: 'finding_notification',
    channelName: 'finding_notification',
    notificationId: 0,
    payload: json.encode(data),
  );
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Karachi'));
}
