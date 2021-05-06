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
}
