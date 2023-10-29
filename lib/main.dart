import 'dart:async';

import 'package:Findings/app/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
  print('backgroundSelectNotification ${payload.payload}');
  //Handle notification tapped logic here
}

Future selectNotification(NotificationResponse payload) async {
  print('selectNotification ${payload.payload}');
  await OpenFilex.open(payload.payload);
}

LocalNotificationService localNotificationService = LocalNotificationService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  await _configureLocalTimeZone();
  await localNotificationService.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
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

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Karachi'));
}

///todo
/// implement manage users
/// add share finding option work on create pdf and download or share
/// add download all
