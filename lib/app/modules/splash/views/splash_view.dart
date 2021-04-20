import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Expanded(child: Container()),
          CircleAvatar(
            radius: 63,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundColor: Colors.red.shade900,
              radius: 60,
              child: RotatedBox(
                quarterTurns: 90,
                child: Image.asset(
                  'assets/images/request.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Text(
                '1.1',
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
