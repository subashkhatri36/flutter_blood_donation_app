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
                ? ListInfo(controller: controller)
                : Center(child: Text('NO REQUEST YET')),
      ),
    );
  }
}

class ListInfo extends StatelessWidget {
  const ListInfo({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final ViewallrequestController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (rmodel.status == 'waiting')
                    InkWell(
                        child: Icon(Icons.check),
                        onTap: () {
                          controller.updateRequest(index, rmodel.id);
                        }),
                  InkWell(
                      child: Icon(Icons.delete),
                      onTap: () {
                        //for delete
                        controller.loadingRequest.toggle();
                        controller.deleteRequest(rmodel.id, rmodel);
                        controller.loadingRequest.toggle();
                      }),
                ],
              )

              // ]),
              );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: controller.requestList.length);
  }
}
