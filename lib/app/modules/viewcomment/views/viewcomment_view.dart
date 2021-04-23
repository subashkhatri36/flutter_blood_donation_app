import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/account/controllers/account_controller.dart';

import 'package:get/get.dart';

import '../controllers/viewcomment_controller.dart';

class ViewcommentView extends GetView<ViewcommentController> {
  @override
  Widget build(BuildContext context) {
    final datalist = Get.find<AccountController>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Comments'),
        ),
        body: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = datalist.commentList[index];
              return Dismissible(
                key: Key(data.id),
                onDismissed: (DismissDirection direction) async {
                  bool val = await controller.deletingComment(data.id);
                  if (val) datalist.commentList.removeAt(index);
                  return val;
                },
                secondaryBackground: Container(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: Defaults.paddingnormal),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      )),
                  color: Colors.red,
                ),
                background: Container(),
                direction: DismissDirection.endToStart,
                child: Padding(
                  padding: const EdgeInsets.all(Defaults.paddingnormal),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Defaults.paddingnormal,
                      ),
                      CircleAvatar(
                        backgroundImage: data.photo.isEmpty
                            ? AssetImage('assets/images/logoapp.png')
                            : NetworkImage(data.photo),
                      ),
                      SizedBox(
                        width: Defaults.paddingnormal,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.name),
                          Text(
                            data.comment,
                            maxLines: 1,
                            style: TextStyle(fontSize: Defaults.fontnormal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: datalist.commentList.length));
  }
}
