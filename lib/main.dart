import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/strings.dart';
import 'package:flutter_blood_donation_app/app/constant/themes/app_theme.dart';
import 'package:flutter_blood_donation_app/app/modules/splash/bindings/splash_binding.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      //initialBinding: SplashBinding(),
    ),
  );
}
