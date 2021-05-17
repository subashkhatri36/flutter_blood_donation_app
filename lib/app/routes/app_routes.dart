part of 'app_pages.dart';

abstract class Routes {
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const CATEGORY = _Paths.CATEGORY;
  static const BLOODGROUP = _Paths.BLOODGROUP;
  static const SPLASH = _Paths.SPLASH;
  static const REQUEST = _Paths.REQUEST;
  static const MYHISTORY = _Paths.MYHISTORY;
  static const DONOR_DETAILS = _Paths.DONOR_DETAILS;
  static const ACCOUNT = _Paths.ACCOUNT;
  static const UPDATEACCOUNT = _Paths.UPDATEACCOUNT;
  static const VIEWALLREQUEST = _Paths.VIEWALLREQUEST;
  static const VIEW_ALL_REVIEWS = _Paths.VIEW_ALL_REVIEWS;
  static const DONATION = _Paths.DONATION;
  static const SETTING = _Paths.SETTING;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;
  static const FORGETPASSWORD = _Paths.FORGETPASSWORD;
  static const MAP_PAGE = _Paths.MAP_PAGE;
}

abstract class _Paths {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const CATEGORY = '/category';
  static const BLOODGROUP = '/bloodgroup';
  static const SPLASH = '/splash';
  static const REQUEST = '/request';
  static const MYHISTORY = '/myhistory';
  static const DONOR_DETAILS = '/donor-details';
  static const ACCOUNT = '/account';
  static const UPDATEACCOUNT = '/updateaccount';
  static const VIEWALLREQUEST = '/viewallrequest';
  static const VIEW_ALL_REVIEWS = '/view-all-reviews';
  //static const CUSTOMMAP = '/custommap';
  static const DONATION = '/donation';
  static const SETTING = '/setting';
  static const NOTIFICATIONS = '/notifications';
  static const FORGETPASSWORD = '/forgetpassword';
  static const MAP_PAGE = '/map-page';
}
