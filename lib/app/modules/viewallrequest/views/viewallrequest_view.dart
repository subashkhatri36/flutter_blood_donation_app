import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';

import 'package:get/get.dart';

import '../controllers/viewallrequest_controller.dart';

List<PopupMenuItem> menuItem = [
  PopupMenuItem(
    child: Text('Cancel'),
    value: '/cancel',
  ),
  PopupMenuItem(
    child: Text('Completed'),
    value: 'completed',
  ),
];

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
                          subtitle: Row(
                            children: [
                              Text(rmodel.hospitaldetail),
                              SizedBox(width: 10),
                              Text(rmodel.status)
                            ],
                          ),
                          trailing: Column(children: [
                            PopupMenuButton(
                                child: Text('Update Status'),
                                onSelected: (v) {
                                  if (v == 'completed')
                                    firebaseFirestore
                                        .collection('request')
                                        .doc(rmodel.id)
                                        .update({
                                      'status': 'completed'
                                    }).whenComplete(() => Get.snackbar(
                                            'Complete',
                                            'Successfully updated'));
                                  else
                                    firebaseFirestore
                                        .collection('request')
                                        .doc(rmodel.id)
                                        .update({
                                      'status': 'canceled'
                                    }).whenComplete(() => Get.snackbar(
                                            'Complete',
                                            'Successfully canceled'));

                                  controller.loadAllRequest();
                                  // print(v);
                                  // Get.snackbar(v, v);
                                },
                                itemBuilder: (context) {
                                  return List.generate(menuItem.length, (i) {
                                    return menuItem[i];
                                  });
                                }),
                            // Text('Update Status'),
                            // InkWell(
                            //   child: Icon(Icons.delete),
                            //   onTap: () {
                            //     print(rmodel.id);
                            //     controller.deleteRequest(rmodel.id, rmodel);
                            //   },
                            // ),
                          ]));
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
