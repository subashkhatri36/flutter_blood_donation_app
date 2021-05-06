import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/timeformatting.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/post_comments/post_comment.dart';
import 'package:flutter_blood_donation_app/app/utlis/size_config.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/home_controller.dart';

class UserRequest extends StatelessWidget {
  final RequestModel request;
  _launchCaller(String e) async {
    String url = "tel:$e";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  const UserRequest({this.request});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            child: Row(
              children: [
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(request.userphotoUrl == ''
                      ? noimage
                      : request.userphotoUrl ?? noimage),
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 15),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '${request.name.capitalize}',
                    style: mediumText.copyWith(
                        fontWeight: FontWeight.w700, color: Colors.grey[700]),
                  ),
                  Text(
                      'looking for ${request.bloodgroup} ${!request.bloodtype ? 'Blood' : 'Platelets'} in ${request.address}',
                      style: smallText.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.grey[700]),
                      overflow: TextOverflow.ellipsis),
                  Text(
                    " ${request.timestamp != null ? TimeFormatting.displayTimeAgoFromTimestamp(request.timestamp.toDate().toString()) : ''}",
                    style: smallText.copyWith(color: Colors.grey),
                  ),
                ]),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
              height: 200,
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.grey,
              child: request.photoUrl != '' || request.photoUrl == null
                  ? Image.memory(
                      base64Decode(request.photoUrl),
                      fit: BoxFit.cover,
                      width: 500,
                      height: 200,
                    )
                  : Image.network(
                      noimage,
                      fit: BoxFit.fill,
                      height: 200,
                      width: 400,
                    )
              // child: CustomMap(zoomEnabled: false, compassEnabled: false),
              ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            height: 60,
            color: Colors.grey.withOpacity(.1),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${request.bloodgroup}',
                          style: largeText.copyWith(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
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
                          Container(
                            width: SizeConfig.screenWidth - 150,
                            child: Text('${request.hospitaldetail} ',
                                overflow: TextOverflow.ellipsis,
                                style: smallText.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ]),
                        Text('${request.address} ,Kathmandu',
                            style: smallText.copyWith(color: Colors.grey)),
                      ]),
                  Container(
                    padding: EdgeInsets.all(4),
                    width: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.purple,
                    ),
                    height: 30,
                    child: InkWell(
                      onTap: () async {
                        if (request.status == 'waiting')
                          _launchCaller(request.contactno);
                      },
                      child: Text(
                        '${request.status == 'waiting' ? 'Call' : 'Completed'}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 5)
                ]),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.grey.withOpacity(.5),
                    child: Icon(
                      Icons.thumb_up_alt_rounded,
                      size: 10,
                    )),
                Text(request.like.abs().toString())
              ],
            ),
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
              // firebaseFirestore
              //     .collection('request')
              //     .doc(widget.request.id)
              //     .delete();
              userController.insertLike(
                  postId: widget.request.id, likeuserId: widget.request.userid);
            },
            child: Row(
              children: [
                SizedBox(
                  width: 4,
                ),
                Obx(() => userController.presslike.isTrue
                    ? Icon(Icons.thumb_up,
                        color: userController.checklikes(widget.request.id)
                            ? Colors.blue
                            : Colors.grey)
                    : Icon(Icons.thumb_up,
                        color: userController.checklikes(widget.request.id)
                            ? Colors.blue
                            : Colors.grey)),
                SizedBox(
                  width: 5,
                ),
                Text('LIKE', style: smallText.copyWith(color: Colors.grey)),
              ],
            )),
        Spacer(),
        TextButton(
          onPressed: () {
            Get.to(
              PostComment(request: widget.request),
            );
          },
          child: Row(
            children: [
              Icon(Icons.comment, color: grey),
              SizedBox(
                width: 5,
              ),
              Text('COMMENTS', style: smallText.copyWith(color: grey)),
            ],
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            RenderBox box = context.findRenderObject();
            Share.share(
                'Blood Donor Needed\n\n' +
                    'Blood Group: ${widget.request.bloodgroup}\nName: ${widget.request.name} \nAddress: ${widget.request.address}\nContact: ${widget.request.contactno}\n->Please Contact in given number if your bloodgroup match to this blood group or else share it.\nYour small help will save someone\'s life.Thank you.\n\n Rakta Daan Mobile App download from play store.',
                subject:
                    'https://post.healthline.com/wp-content/uploads/2020/09/Blood_Donation-732X549-thumbnail.jpg',
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
          },
          child: Row(
            children: [
              Icon(Icons.share, color: grey),
              SizedBox(
                width: 5,
              ),
              Text('SHARE', style: smallText.copyWith(color: grey)),
            ],
          ),
        ),
      ]),
    );
  }
}
