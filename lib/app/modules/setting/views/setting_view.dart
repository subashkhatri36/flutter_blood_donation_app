import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          SizedBox(height: Defaults.paddingbig * 2),
          Text(
            'Set Searching kilometers',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: Defaults.paddingbig),

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

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => Text('${userController.distance.value} km')),
          ),
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
