import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  ScrollController pageviewScroll = new PageController();
  RxInt currentpage = 0.obs;
  final loginformKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  jumppage(BuildContext context) {
    if (currentpage.value == 0) {
      pageviewScroll.jumpTo(0.0);
    } else {
      pageviewScroll.animateTo(MediaQuery.of(context).size.width,
          duration: new Duration(seconds: 0), curve: Curves.ease);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageviewScroll.dispose();
  }
}
