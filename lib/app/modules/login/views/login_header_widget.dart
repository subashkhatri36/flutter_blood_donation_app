import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/constant/strings.dart';

import 'package:flutter_blood_donation_app/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return ClipRRect(
      borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(Defaults.borderRadius * 6)),
      child: Container(
        color :Colors.transparent,
        height: MediaQuery.of(context).size.height * .4,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .4,
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(Defaults.borderRadius * 6)),
                  child: Image.asset('assets/images/bannerImage.jpeg',fit: BoxFit.fill,)),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Image.asset(
                'assets/images/logoapp.png',
                width: Defaults.paddingbig * 10,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: Defaults.borderRadius + 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  if (loginController.currentpage.value == 0) {
                    loginController.currentpage.value = 1;
                  } else {
                    loginController.currentpage.value = 0;
                  }
                  loginController.jumppage(context);
                },
                child: Container(
                  padding: EdgeInsets.all(Defaults.paddingnormal + 5),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Defaults.borderRadius)),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Obx(
                    () => Text(
                      loginController.currentpage.value == 0
                          ? Strings.register
                          : Strings.logIn,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ) ;
  }
}
