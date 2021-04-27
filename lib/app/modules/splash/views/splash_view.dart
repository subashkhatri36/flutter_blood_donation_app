import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';

import 'package:get/get.dart';

import '../../../utlis/size_config.dart';
import '../controllers/splash_controller.dart';

//multiDexEnabled true
//implementation "androidx.multidex:multidex:2.0.1"
// <application
//        android:name="androidx.multidex.MultiDexApplication" >
//       ...
//  </application>
// //https://developer.android.com/studio/build/multidex

class SplashView extends GetView {
  final splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Expanded(child: Container()),
          CircleAvatar(
            radius: 63,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                'assets/images/blooddonation.png',
              ),
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(Defaults.paddingbig),
            child: Row(children: [
              Text(
                'V1.1',
                style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 12),
              ),
              Spacer(),
              Text(
                'Rakta Daan',
                style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 12),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
