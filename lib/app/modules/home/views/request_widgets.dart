import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/timeformatting.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/post_comments/post_comment.dart';
import 'package:flutter_blood_donation_app/app/utlis/size_config.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/home_controller.dart';
import 'donor_profile/donor_profile.dart';

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
                InkWell(
                  onTap: () {
                    UserModel user =
                        userController.getUserByUserid(request.userid);
                    //print(user.username);
                    Get.to(DonorProfile(user: user));
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
                    '${request.name.capitalize}',
                    //capitalize(),
                    style: mediumText.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.grey[600]),
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
                          '${request.bloodgroup}',
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
                          Container(
                            width: SizeConfig.screenWidth - 150,
                            child: Text('${request.detail} Hospital',
                                overflow: TextOverflow.ellipsis,
                                style: smallText.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ]),
                        Text('${request.address} ,Kathmandu',
                            style: smallText.copyWith(color: Colors.grey)),
                      ]),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      width: 50,
                      alignment: Alignment.center,
                      //padding: EdgeInsets.only(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.purple,
                      ),

                      height: 30,
                      child: InkWell(
                        onTap: () async {
                          _launchCaller(userController
                              .userlist[userController
                                  .getUserByUserid(request.userid)]
                              .phoneNo);
                          // String url =
                          //     "tel:${userController.userlist[userController.getUserByUserid(request.userid)].phoneNo}";
                          // if (await canLaunch(url)) {
                          //   await launch(url);
                          // } else {
                          //   print(canLaunch(url));
                          // }
                        },
                        child: Text(
                          'Call',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    // CustomButton(
                    //     label: 'Help',
                    //     labelColor: Colors.white,
                    //     btnColor: Colors.purple,
                    //     borderRadius: 5)
                  ),
                ]),
          ),
          Row(
            children: [
              CircleAvatar(
                  radius: 10,
                  child: Icon(
                    Icons.thumb_up_alt_rounded,
                    size: 10,
                  )),
              Text(request.likes.length.toString())
              // Text(
              //   'Sudarshan and 4 other',
              //   textAlign: TextAlign.start,
              //   style: smallText.copyWith(color: Colors.grey),
              // ),
            ],
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
              widget.request.likes.add(widget.request.userid);

              firebaseFirestore
                  .collection('request')
                  .doc(widget.request.id)
                  .delete()
                  .whenComplete(() => print('completed'));
            },
            child: Row(
              children: [
                // CircleAvatar(
                //     radius: 10,
                //     child: Icon(
                //       Icons.thumb_up_rounded,
                //       size: 12,
                //     )),
                // Text(widget.request.likes.length.toString()),
                SizedBox(
                  width: 4,
                ),
                Icon(Icons.thumb_up,
                    color: widget.request.likes.contains(widget.request.userid)
                        ? Colors.blue
                        : Colors.grey),
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
            // userController.urlFileShare(
            //     'https://healthengine.com.au/info/assets/blood-cells-1024x576.jpg',
            //     context,
            //     'Blood Group ${widget.request.bloodgroup} \Name : ${widget.request.name} \nAddress: ${widget.request.photoUrl}',
            //     'Blood Donor Needed');
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
