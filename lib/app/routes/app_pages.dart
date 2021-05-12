import 'package:get/get.dart';

import 'package:flutter_blood_donation_app/app/modules/ViewAllReviews/bindings/view_all_reviews_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/ViewAllReviews/views/view_all_reviews_view.dart';
import 'package:flutter_blood_donation_app/app/modules/account/bindings/account_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/account/views/account_view.dart';
import 'package:flutter_blood_donation_app/app/modules/donation/bindings/donation_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/donation/views/donation_view.dart';
import 'package:flutter_blood_donation_app/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/home_view.dart';
import 'package:flutter_blood_donation_app/app/modules/login/bindings/login_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/login/views/login_view.dart';
import 'package:flutter_blood_donation_app/app/modules/myhistory/bindings/myhistory_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/myhistory/views/myhistory_view.dart';
import 'package:flutter_blood_donation_app/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/notifications/views/notifications_view.dart';
import 'package:flutter_blood_donation_app/app/modules/request/bindings/request_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/request/views/request_view.dart';
import 'package:flutter_blood_donation_app/app/modules/setting/bindings/setting_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/setting/views/setting_view.dart';
import 'package:flutter_blood_donation_app/app/modules/splash/bindings/splash_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/splash/views/splash_view.dart';
import 'package:flutter_blood_donation_app/app/modules/updateaccount/bindings/updateaccount_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/updateaccount/views/updateaccount_view.dart';
import 'package:flutter_blood_donation_app/app/modules/viewallrequest/bindings/viewallrequest_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/viewallrequest/views/viewallrequest_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

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
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST,
      page: () => RequestView(),
      binding: RequestBinding(),
    ),
    GetPage(
      name: _Paths.MYHISTORY,
      page: () => MyhistoryView(),
      binding: MyhistoryBinding(),
    ),
    // GetPage(
    //   name: _Paths.DONOR_DETAILS,
    //   page: () => DonorDetailsView(),
    //   binding: DonorDetailsBinding(),
    // ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.UPDATEACCOUNT,
      page: () => UpdateaccountView(),
      binding: UpdateaccountBinding(),
    ),
    GetPage(
      name: _Paths.VIEWALLREQUEST,
      page: () => ViewallrequestView(),
      binding: ViewallrequestBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_ALL_REVIEWS,
      page: () => ViewAllReviewsView(),
      binding: ViewAllReviewsBinding(),
    ),
    GetPage(
      name: _Paths.DONATION,
      page: () => DonationView(),
      binding: DonationBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
  ];
}
