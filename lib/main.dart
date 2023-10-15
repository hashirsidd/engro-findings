import 'package:Findings/app/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
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
///todo
/// add graph stats in firebase when approving any findings
