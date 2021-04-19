import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/donor_details_controller.dart';

class DonorDetailsView extends GetView<DonorDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DonorDetailsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DonorDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
