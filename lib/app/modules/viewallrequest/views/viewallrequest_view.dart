import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';

import 'package:get/get.dart';

import '../controllers/viewallrequest_controller.dart';

class ViewallrequestView extends GetView<ViewallrequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Request'),
      ),
      body: Obx(
        () => controller.loadingRequest.isTrue
            ? Center(child: CircularProgressIndicator())
            : controller.requestList.length > 0
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      RequestModel rmodel = controller.requestList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            rmodel.bloodgroup,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text('Searching in ' + rmodel.address),
                        subtitle: Text(rmodel.hospitaldetail),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            print(rmodel.id);
                            controller.deleteRequest(rmodel.id, rmodel);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: controller.requestList.length)
                : Center(child: Text('NO REQUEST YET')),
      ),
    );
  }
}
