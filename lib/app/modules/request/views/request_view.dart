import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/request_controller.dart';

class RequestView extends GetView<RequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RequestView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RequestView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
