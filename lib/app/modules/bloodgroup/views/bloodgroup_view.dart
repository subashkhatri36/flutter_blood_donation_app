import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bloodgroup_controller.dart';

class BloodgroupView extends GetView<BloodgroupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BloodgroupView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BloodgroupView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
