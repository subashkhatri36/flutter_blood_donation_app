import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/themes/app_theme.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_blood_donation_app/app/utlis/rating.dart';
import 'package:flutter_blood_donation_app/app/utlis/size_config.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

void sendSMS(String no) async {
  String url = "sms:$no";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

call(String no) async {
  String url = "tel:$no";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class DonorProfile extends StatelessWidget {
  DonorProfile({this.user});
  final UserModel user;
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    controller.checkUserrating(user.userId);
    controller.loadreview(user);

    return Scaffold(
      body: ListView(
        children: [
          DonorProfileHeader(user: user),
          Container(
            child: Column(
              children: [
                // Text("${user.twostar.toString()}"),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 10),
                  title: Text(
                    'Last Donations',
                    style: largeText.copyWith(
                        fontWeight: FontWeight.w800, color: Colors.grey[700]),
                  ),
                  subtitle: Text('Wednesday , August 4 ,2019'),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 10),
            title: Row(children: [
              Text(
                'All Donations',
                style: largeText.copyWith(
                    fontWeight: FontWeight.w800, color: Colors.grey[700]),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('4 times',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              )
            ]),
            subtitle: Text('Wednesday , August 4 ,2019'),
          ),
          if (FirebaseAuth.instance.currentUser.uid != user.userId)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rate this user',
                    style: largeText.copyWith(
                        fontWeight: FontWeight.w800, color: Colors.grey[700]),
                  ),
                  Text(
                    'Tell others what you think',
                    style: smallText.copyWith(color: Colors.grey[600]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => controller.ratingchange.isTrue
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.redAccent,
                        )
                      : buildStarsRating(user, userratingplace: true)),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(ReviewPage(user: user));
                    },
                    child: Text(
                      'Write a review',
                      style: largeText.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.redAccent[400]),
                    ),
                  ),
                  Obx(() => controller.loadRevew.isTrue
                      ? Container()
                      : Container(
                          // height: MediaQuery.of(context).size.height,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                if (controller.reviewmodellist != null)
                                  if (controller.reviewmodellist.length > 0)
                                    for (int i =
                                            controller.reviewmodellist.length -
                                                1;
                                        i >
                                            controller.reviewmodellist.length -
                                                4;
                                        i--)
                                      Column(
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                                radius: 20,
                                                backgroundImage: controller
                                                        .reviewmodellist[i]
                                                        .photo
                                                        .isEmpty
                                                    ? AssetImage(
                                                        'assets/images/logoapp.png',
                                                      )
                                                    : NetworkImage(controller
                                                        .reviewmodellist[i]
                                                        .photo)),
                                            title: Text(controller
                                                .reviewmodellist[i].name),
                                            subtitle: Text(
                                              controller
                                                  .reviewmodellist[i].comment,
                                              maxLines: 5,
                                            ),
                                          ),
                                          Divider(),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ))
                ],
              ),
            ),
          SizedBox(height: 10),
          Text(
            'Rating and reviews',
            style: mediumText.copyWith(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ...reviews.map((e) => ReviewWidget())
        ],
      ),
    );
  }
}

Row buildStarsRating(UserModel model, {bool userratingplace = false}) {
  final controller = Get.find<HomeController>();

  return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
    //if its a header part then
    //
    if (!userratingplace)
      for (int i = 1; i < 6; i++)
        Container(
          child: Icon(
            calculateAverage(model).round() >= i
                ? Icons.star
                : Icons.star_border,
            color: Colors.redAccent[400],
          ),
        )
    //checking user from bottom part
    else if (controller.userRatingModel != null)
      for (int i = 1; i < 6; i++)
        Container(
          child: InkWell(
              onTap: () {
                controller.setUserrating(i, model);
              },
              child: Icon(
                controller.userRatingModel.star + 1 <= i
                    ? Icons.star_border
                    : Icons.star,
                color: Colors.redAccent[400],
              )),
        )
    else
      for (int i = 1; i < 6; i++)
        Container(
          padding: EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              controller.setUserrating(i, model);
            },
            child: Icon(
              Icons.star_border,
              color: Colors.redAccent,
            ),
          ),
        ),
  ]);
}

class ReviewPage extends StatelessWidget {
  const ReviewPage({
    Key key,
    this.user,
  }) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.close)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  backgroundImage: NetworkImage(user.photoUrl),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    user.username.capitalize,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Rate this user',
                    style: TextStyle(fontSize: 12),
                  ),
                ]),
                Spacer(),
                InkWell(
                  onTap: () {
                    controller.writeUserReview(user);
                  },
                  child: Text(
                    'Post'.toUpperCase(),
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            )),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(userController.myinfo.value.photoUrl),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth - 100,
                    child: Text(
                      userController.myinfo.value.username.capitalize,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Reviews are public and include\n your account details.',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ]),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     for (int i = 0; i < 5; i++)
            //       Container(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           child: Icon(Icons.star_border))
            //   ],
            // ),
            SizedBox(height: 30),
            TextFormField(
                controller: controller.reviewController,
                maxLines: 3,
                decoration: InputDecoration(
                    hintText: 'Describe the user in detail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)))),
            SizedBox(height: 20),
            // Text('Tell us more about user (optional)'),
            // SizedBox(height: 10),
            // Container(
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       border: Border.all(color: Colors.grey)),
            //   height: 140,
            // )
          ],
        ));
  }
}

class DonorProfileHeader extends StatelessWidget {
  final UserModel user;
  const DonorProfileHeader({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: Stack(
          children: [
            Container(
                height: 300,
                width: double.infinity,
                child: Image.network(user.photoUrl, fit: BoxFit.cover)),

            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.grey.withOpacity(.5),
                padding: const EdgeInsets.only(left: 28.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 53,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(user.photoUrl ?? noimage),
                          ),
                        ),
                        Positioned(
                            left: 0,
                            child: CircleAvatar(
                                radius: 17,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    user.bloodgroup,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))),
                      ],
                    )),
              ),
            ),
            Container(
              //color: Colors.grey[500].withOpacity(.5),
              padding: const EdgeInsets.only(left: 5.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            user.username.capitalize,
                            style: largeText.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Container(
                        width: SizeConfig.screenWidth / 2,
                        child: Wrap(runAlignment: WrapAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${user.userAddress.capitalize},Ktm",
                                style: largeText.copyWith(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  // print('phone');
                                  call(user.phoneNo);
                                },
                                child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        Colors.white.withOpacity(.5),
                                    child: Icon(Icons.phone,
                                        color: Colors.redAccent[400],
                                        size: 15)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  print('sms');
                                  sendSMS(user.phoneNo);
                                },
                                child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        Colors.white.withOpacity(.5),
                                    child: Icon(Icons.message,
                                        color: Colors.redAccent[400],
                                        size: 15)),
                              )
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
            ),
            Positioned(
              bottom: 20,
              right: 15,
              width: SizeConfig.screenWidth / 2,
              child: Container(
                  padding: EdgeInsets.only(top: 20, left: 8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: BorderRadius.circular(5)),
                  height: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ratings ',
                              style: mediumText.copyWith(
                                  color: Colors.white,
                                  letterSpacing: 3,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),

                              // Icon(
                              //   Icons.info_outline,
                              //   color: Colors.white,
                              //   size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ]),
                      SizedBox(height: 5),
                      Text(
                        calculateAverage(user).toStringAsPrecision(2),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                      buildStarsRating(user),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     for (int i = 0; i < 5; i++)
                      //       Icon(Icons.star, color: Colors.redAccent[400])
                      //   ],
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        ' ' + totalvalue(user).toInt().toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      for (int i = 5; i > 0; i--)
                        Row(
                          children: [
                            SizedBox(width: 6),
                            Text(
                              i.toString(),
                              style: mediumText.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: LinearPercentIndicator(
                                lineHeight: 5.0,
                                percent: showpercentage(i, user),
                                backgroundColor: Colors.white,
                                progressColor: Colors.redAccent[400],
                              ),
                            ),
                            // Container(
                            //     width: SizeConfig.screenWidth / 2 - 50,
                            //     child: Stack(
                            //       children: [
                            //         Container(
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(20),
                            //             color: Colors.white,
                            //           ),
                            //           height: 7,
                            //         ),
                            //         Container(
                            //           width:
                            //               .50 * SizeConfig.screenWidth / 2 - 50,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(20),
                            //             color: Colors.redAccent[400],
                            //           ),
                            //           height: 7,
                            //         ),
                            //       ],
                            //     )),
                          ],
                        ),
                    ],
                  )),
            ),

            Positioned(
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(10))),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ))
            //Container(height: 100, color: Colors.white),
            //   Positioned(
            //     child: Container(
            //       height: 100,
            //       child: Row(
            //         children: [
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               CircleAvatar(
            //                 backgroundImage: NetworkImage(noimage),
            //               ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //               Text(
            //                 'Sudarshan',
            //                 style: largeText.copyWith(color: Colors.white),
            //               ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //             ],
            //           ),
            //           Spacer(),
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               Text(
            //                 'Blood Type',
            //                 style: mediumText.copyWith(color: Colors.white),
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text(
            //                 '0+',
            //                 style: largeText.copyWith(color: Colors.white),
            //               ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               Text(
            //                 'Units Dontaed',
            //                 style: mediumText.copyWith(color: Colors.white),
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text(
            //                 '0+',
            //                 style: largeText.copyWith(color: Colors.white),
            //               ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //   )
          ],
        ));
  }
}

List reviews = [1, 2, 3, 4, 5, 6];

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      // color: Colors.deepOrange,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(
                  'no image',
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Rich Tend',
                style: TextStyle(),
              ),
              Spacer(),
              Icon(
                Icons.more_vert,
                color: Colors.grey[700],
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              for (int i = 0; i < 5; i++)
                Icon(
                  Icons.star_border,
                  size: 14,
                ),
              SizedBox(width: 5),
              Text(
                DateTime.now().toString().substring(0, 10),
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "A fearless junior policeman ( #MarkChao​ ), who can only see right and wrong is willing to do anything to uncover the truth. Meanwhile a gangster ( #HuangBo​ ), who fears death above anything else is struggling to stay out of serious trouble, his risky decisions have left his life at threat. Two people with completely different perspectives on life come together as partners in a way no one could ever imagine. Somehow, the fate of the world ends up in their hands; they have 36 hours to resolve a crisis which could destroy Harbor City…   ",
            style: TextStyle(
              color: Colors.grey[600],
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Was this review helpful?',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Text(
                  ' Yes ',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Text(
                  ' No ',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
