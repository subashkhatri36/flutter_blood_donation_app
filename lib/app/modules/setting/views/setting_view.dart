import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/setting_controller.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
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
          // ListTile(
          //   onTap: () {
          //     Get.toNamed(
          //       '/notifications',
          //     ); //,transition: Transition.rightToLeft);
          //   },
          //   title: Text('Notifications'),
          // ),
          Row(
            children: [
              Obx(
                () => Checkbox(
                    value: controller.notification,
                    onChanged: (v) {
                      controller.shownotification.value = v;
                    }),
              ),
              Text('Show Notification')
            ],
          ),
          ListTile(
              onTap: () {
                Get.to(HelpFeedbackReport(title: 'Help'),
                    transition: Transition.rightToLeft);
              },
              title: Text('Get Help')),

          ListTile(
            onTap: () {
              Get.to(HelpFeedbackReport(title: 'Feedback'),
                  transition: Transition.rightToLeft);
            },
            title: Text('Give Feedback'),
          ),

          ListTile(
            onTap: () {
              Get.to(HelpFeedbackReport(title: 'Report Problem'),
                  transition: Transition.rightToLeft);
            },
            title: Text('Report problem'),
          ),

          ListTile(
            onTap: () {
              Get.to(HelpFeedbackReport(title: 'Suggest Feature'),
                  transition: Transition.rightToLeft);
            },
            title: Text('Suggest Feature'),
          ),

          ListTile(
              onTap: () {
                launch('market://details');
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
          // ListTile(
          //   //  contentPadding: EdgeInsets.zero,
          //   onTap: () {
          //     Get.to(FeedBackandHelp());
          //   },
          //   title: Text(
          //     'Help & Feedback',
          //     style: mediumText.copyWith(
          //         fontWeight: FontWeight.bold, color: Colors.grey[700]),
          //   ),
          // )
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.save),
      //     onPressed: () {
      //       print(localStorage.read('myinfo'));

      //     }),
    );
  }
}

class HelpFeedbackReport extends StatelessWidget {
  const HelpFeedbackReport({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
                'Enter ${title == 'Feedback' ? 'Feedback' : title == 'Report problem' ? 'problem' : title == 'Suggest Feature' ? 'Feature' : 'queries'}',
                style: smallText.copyWith()),
          ),
          TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: 'Describe  details',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)))),
          SizedBox(height: 20),
          TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.red.shade900,
                  primary: Colors.white),
              onPressed: () {},
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Send')]))
        ]),
      ),
    );
  }
}
