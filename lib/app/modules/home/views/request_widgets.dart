import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/timeformatting.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/post_comments/post_comment.dart';
import 'package:get/get.dart';

import '../../../Widgets/CustomButton.dart';
import '../controllers/home_controller.dart';

class UserRequest extends StatelessWidget {
  final RequestModel request;

  const UserRequest({this.request});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(children: [
          SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            child: Row(
              children: [
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    // UserModel user =
                    userController.getUserByUserid(request.userid);
                    //print(user.username);
                    // Get.to(DonorProfile(user: user));
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blueGrey[700],
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(request.userphotoUrl == ''
                          ? noimage
                          : request.userphotoUrl ?? noimage),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    request.name.capitalize,
                    //capitalize(),
                    style: mediumText.copyWith(fontWeight: FontWeight.w400),
                  ),
                  Text(
                      'looking for ${request.bloodgroup}  in ${request.address}',
                      style: smallText.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.grey[700]),
                      overflow: TextOverflow.ellipsis),
                  Text(
                    " ${request.timestamp != null ? TimeFormatting.displayTimeAgoFromTimestamp(request.timestamp.toDate().toString()) : ''}",
                    style: smallText.copyWith(color: Colors.grey),
                  ),
                ]),
                Spacer(),
                SizedBox(width: 10),
                Icon(Icons.more_horiz, color: Colors.grey),
                SizedBox(width: 10),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey,
              child: Image.memory(base64Decode(request.photoUrl),
                  fit: BoxFit.cover)
              // child: CustomMap(zoomEnabled: false, compassEnabled: false),
              ),
          SizedBox(height: 10),
          Container(
            height: 60,
            padding: EdgeInsets.only(left: 10),
            color: Colors.grey.withOpacity(.1),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          request.bloodgroup,
                          style: mediumText.copyWith(color: Colors.grey[900]),
                        ),
                      ]),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Blood Donors Needed'),
                        Row(children: [
                          Icon(Icons.location_on, size: 16, color: Colors.grey),
                          Text('${request.detail} Hospital',
                              style: smallText.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400)),
                        ]),
                        Text('${request.address} ,Kathmandu',
                            style: smallText.copyWith(color: Colors.grey)),
                        //
                      ]),
                  Spacer(),
                  Container(
                      width: 60,
                      padding: EdgeInsets.only(right: 10),
                      //   color: Colors.purple,
                      height: 30,
                      child: CustomButton(
                          label: 'Help',
                          labelColor: Colors.white,
                          btnColor: Colors.purple,
                          borderRadius: 5)),
                ]),
          ),
          SizedBox(width: 5),
          LikeButton(request: request),
        ]),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton({
    Key key,
    @required this.request,
  }) : super(key: key);

  final RequestModel request;

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(right: 10),
      child: Row(children: [
        TextButton(
            onPressed: () {
              //  print(userController.requestData.indexOf(request));
              // LikeModel like =
              //     LikeModel(userid: request.userid, liked: true);
              if (widget.request.likes.contains(widget.request.userid)) {
                setState(() {
                  widget.request.likes.remove(widget.request.userid);
                });
              } else {
                setState(() {
                  widget.request.likes.add(widget.request.userid);
                });
              }
              // request.likes.forEach((element) {
              //   if (element.userid ==
              //       userController.myinfo.value.userId) {
              //     int index = request.likes.indexOf(element);
              //   }
              // });
              print(widget.request.likes.length);
              // firebaseFirestore
              //     .collection('request')
              //     .doc(request.id)
              //     .delete()
              //     .whenComplete(() => print('completed'));
            },
            child: Row(
              children: [
                CircleAvatar(
                    radius: 10,
                    child: Icon(
                      Icons.thumb_up_rounded,
                      size: 12,
                    )),
                Text(widget.request.likes.length.toString()),
                SizedBox(
                  width: 4,
                ),
                Icon(Icons.thumb_up,
                    color: widget.request.likes.contains(widget.request.userid)
                        ? Colors.blue
                        : Colors.grey),
                SizedBox(
                  width: 10,
                ),
                Text('LIKE', style: mediumText.copyWith(color: Colors.grey)),
              ],
            )),
        Spacer(),
        TextButton(
          onPressed: () {
            Get.to(PostComment());
          },
          child: Row(
            children: [
              Icon(Icons.comment, color: grey),
              SizedBox(
                width: 10,
              ),
              Text('COMMENTS(3)', style: mediumText.copyWith(color: grey)),
            ],
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(Icons.share, color: grey),
              SizedBox(
                width: 10,
              ),
              Text('SHARE', style: mediumText.copyWith(color: grey)),
            ],
          ),
        ),
      ]),
    );
  }
}
