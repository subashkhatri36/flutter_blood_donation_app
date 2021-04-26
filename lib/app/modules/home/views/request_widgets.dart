import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/timeformatting.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';

import '../../../Widgets/CustomButton.dart';

class UserRequest extends StatelessWidget {
  final RequestModel user;

  const UserRequest({this.user});
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
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueGrey[700],
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: user.userphotoUrl != null
                        ? NetworkImage(user.userphotoUrl)
                        : AssetImage(
                            'assets/images/blooddonation.png',
                          ),
                    backgroundColor: Colors.grey,
                  ),
                ),
                SizedBox(width: 15),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    user.name,
                    //capitalize(),
                    style: mediumText.copyWith(fontWeight: FontWeight.w400),
                  ),
                  Text('looking for ${user.bloodgroup}  in ${user.address}',
                      style: smallText.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.grey[700]),
                      overflow: TextOverflow.ellipsis),
                  Text(
                    " ${user.timestamp != null ? StringExtension.displayTimeAgoFromTimestamp(user.timestamp.toDate().toString()) : ''}",
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
              height: 150,
              width: double.infinity,
              color: Colors.grey,
              child:
                  Image.memory(base64Decode(user.photoUrl), fit: BoxFit.cover)
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
                          user.bloodgroup,
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
                          Text('${user.detail} Hospital',
                              style: smallText.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400)),
                        ]),
                        Text('${user.address} ,Kathmandu',
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
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.thumb_up, color: Colors.grey),
                  InkWell(
                      onTap: () {
                        // firebaseFirestore
                        //     .collection('request')
                        //     .doc(user.id)
                        //     .delete();
                      },
                      child: Text('LIKE',
                          style: mediumText.copyWith(color: Colors.grey))),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.comment, color: grey),
                  Text('COMMENT', style: mediumText.copyWith(color: grey)),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.share, color: grey),
                  Text('SHARE', style: mediumText.copyWith(color: grey)),
                ],
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
