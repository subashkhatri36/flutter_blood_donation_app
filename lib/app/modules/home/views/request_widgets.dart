import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/timeformatting.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';

import '../../../Widgets/CustomButton.dart';

class UserRequest extends StatelessWidget {
  final RequestModel user;

  const UserRequest({Key key, this.user}) : super(key: key);
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
                  backgroundImage: NetworkImage(user.photoUrl),
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 5),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    user.name,
                    style: mediumText.copyWith(fontWeight: FontWeight.w400),
                  ),
                  Text('looking for ${user.bloodgroup}  in ${user.address}',
                      style: smallText, overflow: TextOverflow.ellipsis),
                  Text(
                    StringExtension.displayTimeAgoFromTimestamp(
                        user.timestamp.toString()),
                    style: smallText.copyWith(color: Colors.grey),
                  )
                ]),
                Spacer(),
                SizedBox(width: 10),
                Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey,
              child: Image.network('https://i.stack.imgur.com/HILmr.png',
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
                          user.bloodgroup,
                          style: mediumText.copyWith(color: Colors.grey[900]),
                        ),
                      ]),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Blood Donors Needed'),
                        Row(children: [
                          Icon(Icons.location_on, size: 16, color: Colors.grey),
                          Text('Textas Children\'s Hospital,',
                              style: smallText.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400)),
                        ]),
                        Text('Houston ,TX',
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
                  Icon(Icons.thumb_up, color: Colors.grey),
                  Text('LIKE', style: mediumText.copyWith(color: Colors.grey)),
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
