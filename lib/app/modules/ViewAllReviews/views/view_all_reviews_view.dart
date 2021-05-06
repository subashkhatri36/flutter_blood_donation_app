import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';

import 'package:get/get.dart';

import '../controllers/view_all_reviews_controller.dart';

class ViewAllReviewsView extends GetView<ViewAllReviewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: Obx(
        () => controller.isloading.isTrue
            ? Center(child: CircularProgressIndicator())
            : ListWidiget(),
      ),
    );
  }
}

class ListWidiget extends StatelessWidget {
  const ListWidiget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ViewAllReviewsController>();
    // print(controller.reviewModelList.length);

    return Obx(() => ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        reverse: true,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final data = controller.reviewModelList[index];
          print(data);
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: data.photo.isEmpty
                  ? AssetImage('assets/images/logoapp.png')
                  : NetworkImage(data.photo),
            ),
            trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  return showDialog(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete Dialog'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Are you Su)re to delete your Request.'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Delete'),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await controller.deletingComment(data.id, data);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }),
            title: Text(data.name),
            subtitle: Text(
              data.comment,
              maxLines: 1,
              style: TextStyle(fontSize: Defaults.fontnormal),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: controller.reviewModelList?.length ?? 0));
  }
}
