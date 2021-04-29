import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/utlis/size_config.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorProfile extends StatelessWidget {
  DonorProfile({this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          DonorProfileHeader(user: user),
          Divider(),
          // Container(
          //   color: Colors.grey[300],
          //   child: Column(
          //     children: [
          //       ListTile(
          //         leading: CircleAvatar(),
          //         title: Text('Schedule New Appoinment'),
          //         subtitle: Text('Choose time and location and donation type'),
          //       ),
          //       ListTile(
          //           leading: CircleAvatar(),
          //           title: Text('Schedule New Appoinment'),
          //           subtitle:
          //               Text('Choose time and location and donation type')),
          //     ],
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(left: 10),
            color: Colors.grey[300].withOpacity(.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ListTile(
                //   title: Text(
                //     'Address',
                //     style: mediumText,
                //   ),
                //   subtitle: Text('Ranibari, Kathmandu'),
                // ),
                // Divider(),
                // ListTile(
                //   title: Text(
                //     'Email',
                //     style: mediumText,
                //   ),
                //   subtitle: Text('s@gmail.com'),
                // ),
                // Divider(),
                // ListTile(
                //   title: Text(
                //     'Contact',
                //     style: mediumText,
                //   ),
                //   subtitle: Text('0542131'),
                // ),
                // ListTile(
                //   title: Text(
                //     '984276234',
                //     style: mediumText,
                //   ),
                //   subtitle: Text('Ranibari, Kathmandu'),
                //   trailing: InkWell(onTap: () {}, child: Icon(Icons.phone)),
                // ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phone',
                  style: largeText.copyWith(
                      color: Colors.grey[800], fontWeight: FontWeight.bold),
                ),
                Card(
                  child: ListTile(
                    leading: Card(child: Icon(CupertinoIcons.phone)),
                    title: Text(
                      user.phoneNo,
                      style: largeText,
                    ),
                    subtitle: Text(''),
                    trailing: IconButton(
                      icon: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(
                          CupertinoIcons.phone,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        String url = 'tel:${user.phoneNo}';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Last Donations',
                    style: largeText.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Wednesday , August 4 ,2019'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Card(
                            child: Icon(Icons.water_damage),
                          ),
                          title: Text('2 Dontations(Year to Date)'),
                          subtitle: Text('Blood'),
                        ),
                        // ListTile(
                        //   leading: Card(
                        //     child: Icon(Icons.water_damage),
                        //   ),
                        //   title: Text('2 Dontations(Year to Date)'),
                        //   subtitle: Text('Blood'),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ListTile(
                title: Text(
                  'All Donations',
                  style: largeText.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Wednesday , August 4 ,2019'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Card(
                          child: Icon(Icons.water_damage),
                        ),
                        title: Text('2 Dontations(Year to Date)'),
                        subtitle: Text('Blood'),
                      ),
                      // ListTile(
                      //   leading: Card(
                      //     child: Icon(Icons.water_damage),
                      //   ),
                      //   title: Text('2 Dontations(Year to Date)'),
                      //   subtitle: Text('Blood'),
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                //  height: 180,
                color: Colors.grey[400].withOpacity(.5),
                child: Column(
                  children: [
                    Text(
                      'Rate User',
                      style: mediumText.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 5; i++)
                          Icon(
                            Icons.star,
                            size: 30,
                          )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DonorProfileHeader extends StatelessWidget {
  final UserModel user;
  const DonorProfileHeader({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        //padding: EdgeInsets.only(left: 20),
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      image: NetworkImage(user.photoUrl), fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 62,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 60,
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
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user.username.capitalize,
                            style: largeText.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                     
                      Row(children: [
                        Text(
                          user.userAddress.capitalize,
                          style: largeText.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20),
                        CircleAvatar(child: Icon(Icons.message))
                      ]),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
            ),
            Positioned(
              top: 20,
              right: 8,
              width: SizeConfig.screenWidth / 2,
              child: Container(
                  padding: EdgeInsets.only(top: 20),
                  color: Colors.grey.withOpacity(.7),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'User Review',
                        style: mediumText.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 5; i++) Icon(Icons.star)
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 6),
                          Text(
                            '1',
                            style: mediumText.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(Icons.star),
                          Container(
                              width: SizeConfig.screenWidth / 2 - 40,
                              child: LinearProgressIndicator(
                                value: .14,
                                backgroundColor: Colors.grey,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 6),
                          Text(
                            '1',
                            style: mediumText.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(Icons.star),
                          Container(
                              width: SizeConfig.screenWidth / 2 - 40,
                              child: LinearProgressIndicator(
                                value: .14,
                                backgroundColor: Colors.grey,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 6),
                          Text(
                            '1',
                            style: mediumText.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(Icons.star),
                          Container(
                              width: SizeConfig.screenWidth / 2 - 40,
                              child: LinearProgressIndicator(
                                value: .14,
                                backgroundColor: Colors.grey,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 6),
                          Text(
                            '1',
                            style: mediumText.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(Icons.star),
                          Container(
                              width: SizeConfig.screenWidth / 2 - 40,
                              child: LinearProgressIndicator(
                                value: .14,
                                backgroundColor: Colors.grey,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 6),
                          Text(
                            '1',
                            style: mediumText.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(Icons.star),
                          Container(
                              width: SizeConfig.screenWidth / 2 - 40,
                              child: LinearProgressIndicator(
                                value: .14,
                                backgroundColor: Colors.grey,
                              )),
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
                      // gradient: LinearGradient(colors: [
                      //   Colors.white,
                      //   Colors.yellow,
                      // ]),
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
