import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/myhistory_controller.dart';

class MyhistoryView extends GetView<MyhistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyhistoryView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MyhistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
