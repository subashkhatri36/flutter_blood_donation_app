import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';

import 'package:get/get.dart';

import '../controllers/setting_controller.dart';
// import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final controller = Get.put(SettingController());

  // double _lowerValue = 10.0;
  // double _upperValue = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Defaults.paddingbig * 2),
            Center(
              child: Text(
                'Set Search Distance ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: Defaults.paddingbig),

            // Obx(() => Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text('${controller.minkilo.value} km'),
            //     )),
            Center(
              child: Obx(
                () => CupertinoSlider(
                    max: 100,
                    divisions: 19,
                    min: 5,
                    value: userController.distance.value,
                    activeColor: Colors.red.shade600,
                    thumbColor: Colors.red.shade600,
                    onChanged: (v) {
                      userController.distance.value = v.toPrecision(2);
                      userController.writeSettings();
                    }),
              ),
            ),

            // Expanded(
            //   child: frs.RangeSlider(
            //     min: 0.0,
            //     max: 100.0,
            //     lowerValue: _lowerValue,
            //     upperValue: _upperValue,
            //     divisions: 10,
            //     showValueIndicator: true,
            //     valueIndicatorMaxDecimals: 1,
            //     onChanged:
            //         (double newLowerValue, double newUpperValue) {
            //       setState(() {
            //         controller.minkilo.value =
            //             _lowerValue = newLowerValue;
            //         userController.distance.value = newUpperValue;
            //         // print(userController.distance.value);
            //         controller.maxkilo.value =
            //             _upperValue = newUpperValue;
            //       });
            //     },
            //     onChangeStart:
            //         (double startLowerValue, double startUpperValue) {
            //       print(
            //           'Started with values: $startLowerValue and $startUpperValue');
            //     },
            //     onChangeEnd:
            //         (double newLowerValue, double newUpperValue) {
            //       print(
            //           'Ended with values: $newLowerValue and $newUpperValue');
            //     },
            //   ),
            // ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => Text(
                      '${userController.distance.value} km',
                      style: mediumText.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.grey[600]),
                    )),
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Get.to(FeedBackandHelp());
              },
              title: Text(
                'Help & Feedback',
                style: mediumText.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.grey[700]),
              ),
            )
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.save),
      //     onPressed: () {
      //       print(localStorage.read('myinfo'));

      //     }),
    );
  }
}

class FeedBackandHelp extends StatelessWidget {
  const FeedBackandHelp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help and feedback',
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(title: Text('Help')),
        ListTile(
          title: Text('Feedback'),
        ),
        ListTile(
          title: Text('Give Feedback'),
        ),
        ListTile(
          title: Text('Report problem'),
        ),
        ListTile(
          title: Text('Suggest Feature'),
        ),
        ListTile(
            onTap: () {
              //to rate app on playstore

              // try {
              //   launch("market://details?id=" + appPackageName);
              // } on PlatformException catch (e) {
              //   launch(
              //       "https://play.google.com/store/apps/details?id=" +
              //           appPackageName);
              // } finally {
              //   launch(
              //       "https://play.google.com/store/apps/details?id=" +
              //           appPackageName);
              // }
            },
            title: Text('Rate us'))
      ]),
    );
  }
}
