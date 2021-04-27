import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/strings.dart';
import 'package:flutter_blood_donation_app/app/constant/themes/app_theme.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utlis/size_config.dart';

//AIzaSyAYYYAaAm5p6UXOv0vyKElcarUaWMgQvzI
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
