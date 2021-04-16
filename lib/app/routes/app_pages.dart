import 'package:get/get.dart';

import 'package:flutter_blood_donation_app/app/modules/bloodgroup/bindings/bloodgroup_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/bloodgroup/views/bloodgroup_view.dart';
import 'package:flutter_blood_donation_app/app/modules/category/bindings/category_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/category/views/category_view.dart';
import 'package:flutter_blood_donation_app/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/home_view.dart';
import 'package:flutter_blood_donation_app/app/modules/login/bindings/login_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.BLOODGROUP,
      page: () => BloodgroupView(),
      binding: BloodgroupBinding(),
    ),
  ];
}
