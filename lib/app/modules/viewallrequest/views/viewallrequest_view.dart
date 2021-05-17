import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
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
              //  tileColor: Colors.redAccent[100],
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
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green[300],
                        //border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.all(4),
                    child: Text(rmodel.status,
                        style: smallText.copyWith(color: Colors.white)),
                  )
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (rmodel.status == 'waiting')
                    InkWell(
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey.withOpacity(.5),
                          child: Icon(
                            Icons.check,
                            size: 15,
                            color: Colors.green[800],
                          ),
                        ),
                        onTap: () {
                          controller.updateRequest(index, rmodel.id);
                        }),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.grey.withOpacity(.5),
                        child: Icon(
                          Icons.delete,
                          size: 15,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
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
