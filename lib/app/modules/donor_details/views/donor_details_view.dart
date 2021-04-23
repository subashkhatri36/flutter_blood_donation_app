import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/modules/login/views/registration_widget.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/donor_details_controller.dart';

class DonorDetailsView extends GetView<DonorDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DonorList',
          style: largeText,
        ),
        actions: [
          IconButton(
              icon: Text(
                'AB -',
                style: mediumText.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
              onPressed: () {})
        ],
      ),
      body: //Obx(() => Text(controller.mylongitude.toString()))

          Obx(
        () => controller.donorlist.length != 0
            ? ListView.builder(
                itemCount: controller.donorlist.length,
                itemBuilder: (_, int i) {
                  return ListTile(
                      contentPadding: EdgeInsets.only(left: 5, right: 5),
                      title: SortedItem(controller.donorlist[i], controller));
                })
            : Center(
                child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor),
              ),
      ),
    );
  }
}

class SortedItem extends StatelessWidget {
  SortedItem(this.u, this.controller);
  final DonorDetailsController controller;
  final UsermodelSortedtoMyLocationModel u;
  _launchCaller() async {
    String url = "tel:${controller.userlist[u.donorindex].phoneNo}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(.4),
        ),
        width: double.infinity,
        height: 120,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(controller
                            .userlist[u.donorindex].photoUrl ??
                        'https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png'),
                    fit: BoxFit.cover),
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(5)),
            height: 100,
            width: 100,
          ),
          SizedBox(width: 10),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(user[u.donorindex].photoUrl),
                Text(controller.userlist[u.donorindex].username),
                SizedBox(
                  height: 10,
                ),
                Row(children: [
                  InkWell(
                    onTap: () {
                      //  Get.to(LoginView());
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 15,
                          child: Icon(Icons.more_horiz,
                              color: Colors.grey[700], size: 18)),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      _launchCaller();
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.green[200],
                        radius: 16,
                        child: RotatedBox(
                            quarterTurns: 35,
                            child: Icon(Icons.phone,
                                color: Colors.green[700], size: 15))),
                  )
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    // Text((user[u.donorindex].rating[1] /
                    //         user[u.donorindex].rating[0])
                    //     .toString()),
                    for (int i = 1; i < 5; i++)
                      InkWell(
                        onTap: () {
                          controller.favourite.value = i;
                          print(controller.favourite.value);
                        },
                        child: Obx(
                          () => controller.favourite.value == 0
                              ? Icon(i >= i ? Icons.star : Icons.star_border,
                                  color: i >= i
                                      ? Colors.deepOrange[400]
                                      : Colors.grey)
                              : Text(''),
                        ),
                      )
                  ],
                )
              ]),
          Spacer(),
          Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Container()),
                Text("${u.distance.toStringAsFixed(2)}km"),
                SizedBox(width: 10),
              ]),
          SizedBox(width: 10),
        ]));
  }
}
