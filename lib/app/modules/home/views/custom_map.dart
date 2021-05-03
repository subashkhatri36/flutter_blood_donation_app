import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/donor_details/controllers/donor_details_controller.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/model/user_models.dart';
import '../../../utlis/size_config.dart';
import 'donor_profile/donor_profile.dart';

class CustomMap extends StatefulWidget {
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  final donorController = Get.find<DonorDetailsController>();
  GoogleMapController mapController;
  BitmapDescriptor customIcon;
  BitmapDescriptor userIcon;
  List<BitmapDescriptor> mapicons = [];
  Set<Marker> markers;
  double mylatitude;
  double mylongitude;
  UserModel selectedUser;
  List<DropdownMenuItem> items = [];
  double pinPillPosition = -100;
  List<UsermodelSortedtoMyLocationModel> allusers = [];
  String selectedbloodgroup;
  List bloodicons = [
    'assets/images/apositive.png',
    'assets/images/anegative.png',
    'assets/images/bpositive.png',
    'assets/images/bnegative.png',
    'assets/images/abpositive.png',
    'assets/images/abnegative.png',
    'assets/images/opositive.png',
    'assets/images/onegative.png',
  ];

  Timer timer;

  void startTimer() {
    //print('timer started');
    // setState(() {
    //   _start = 10;
    // });
    const sec = Duration(seconds: 4);
    timer = Timer(sec, () {
      setState(() {
        pinPillPosition = -100;
      });
      // print('timer stopped');
    });
  }

  createMarker(context, image) {
    ImageConfiguration config =
        createLocalImageConfiguration(context, size: Size(10, 10));
    BitmapDescriptor.fromAssetImage(
      config,
      image,
    ).then((icon) {
      setState(() {
        customIcon = icon;
      });
    });
  }

  createIcon(context, image) {
    ImageConfiguration config =
        createLocalImageConfiguration(context, size: Size(10, 10));
    BitmapDescriptor.fromAssetImage(
      config,
      image,
    ).then((icon) {
      setState(() {
        mapicons.add(icon);
      });
    });
  }

  userMarker(context, image) {
    ImageConfiguration config =
        createLocalImageConfiguration(context, size: Size(10, 10));

    BitmapDescriptor.fromAssetImage(
      config,
      image,
    ).then((icon) {
      setState(() {
        userIcon = icon;
      });
    });
  }

  addMarker() {
    userController.userlist.toList().forEach((element) {
      if (element.userId != userController.myinfo.value.userId)
        markers.add(Marker(
          icon: mapicons[bloodgroup.indexOf(element.bloodgroup)],
          markerId: MarkerId('${element.userId}'),
          position: LatLng(element.latitude, element.longitude),
          //consumeTapEvents: true,
          // infoWindow: InfoWindow(
          //     title: '${element.username}', snippet: "${element.userAddress}"),
          onTap: () {
            print('tapp');
            setState(() {
              pinPillPosition = 0;
              selectedUser = element;
            });
            startTimer();
          },
        ));
      else //if (element.bloodgroup == selectedbloodgroup)
        markers.add(Marker(
          icon: userIcon,
          markerId: MarkerId('${element.userId}'),
          position: LatLng(element.latitude, element.longitude),
          consumeTapEvents: true,
          infoWindow: InfoWindow(
              title: '${element.username}', snippet: "${element.userAddress}"),
          onTap: () {
            setState(() {
              pinPillPosition = 0;
              selectedUser = element;
            });
            startTimer();
          },
        ));
    });
  }

  @override
  void initState() {
    super.initState();

    markers = Set.from([]);
    //  setUser();
    selectedbloodgroup = userController.myinfo.value.bloodgroup;
    selectedUser = userController.myinfo.value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  setUser() {
    // List<UsermodelSortedtoMyLocationModel> users =
    //     donorController.getDonors(selectedbloodgroup);
    //print(users.length);
    // setState(() {
    //   allusers = users;
    // });
  }

  createmarker(context) {
    bloodicons.forEach((element) {
      createIcon(context, element);
    });
  }

  _launchCaller(e) async {
    String url = "tel:${userController.userlist[e.donorindex].phoneNo}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    userMarker(context, 'assets/images/defaultuser.png');
    allusers = donorController.getDonors(selectedbloodgroup);
    createmarker(context);

    return Stack(
      children: [
        // InkWell(
        //     onTap: () {
        //       setState(() {
        //         selectedbloodgroup = 'A+';
        //       });
        //     },
        //     child: Text(selectedbloodgroup)),
        // if (!userController.userlistshown.value)
        // ? Container(
        //     child: Text(selelctedbloodgruop),
        //   )
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              zoom: 16.0,
              target: LatLng(userController.mylatitude.value,
                  userController.mylongitude.value)),
          myLocationEnabled: true,
          onTap: (pos) {
            setState(() {
              pinPillPosition = -100;
            });
          },
          // myLocationButtonEnabled: true,
          markers: markers,
          onMapCreated: (GoogleMapController controller) {
            addMarker();
            setState(() {
              mapController = controller;
            });

            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    zoom: 16.0,
                    target: LatLng(userController.mylatitude.value,
                        userController.mylongitude.value))));
          },
        ),
        if (userController.userlistshown.value)
          Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 5),
              children: [
                Row(
                  children: [
                    Text(
                      'Donors Available',
                      style: largeText.copyWith(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    // Text(
                    //   'SortBy:',
                    //   style: TextStyle(
                    //       color: Colors.grey, fontWeight: FontWeight.bold),
                    // ),
                    DropdownButton(
                        onChanged: (v) {
                          setState(() {
                            allusers =
                                donorController.getDonors(selectedbloodgroup);
                            // print(allusers.length);
                            selectedbloodgroup = v;
                          });
                        },
                        value: selectedbloodgroup,
                        items: [
                          ...bloodgroup.map((e) => DropdownMenuItem(
                                value: e,
                                child: Container(child: Text(e)),
                              ))
                        ]),
                  ],
                ),
                ...allusers.map((e) => ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    onTap: () {
                      Get.to(DonorProfile(
                          user: userController.userlist[e.donorindex]));
                    },
                    // isThreeLine: true,
                    leading: Container(
                      width: 60,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.deepOrange,
                              radius: 25,
                              backgroundImage: NetworkImage(userController
                                  .userlist[e.donorindex].photoUrl),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12,
                              child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 10,
                                  child: Text(
                                    'AB+',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    title: Text(e.name),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userController
                              .userlist[e.donorindex].userAddress),
                          Text("${(e.distance / 1000).toStringAsFixed(2)}Km"),
                        ]),
                    trailing: Column(children: [
                      InkWell(
                          onTap: () {
                            mapController.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                              bearing: 45,
                              target: LatLng(
                                  userController
                                      .userlist[e.donorindex].latitude,
                                  userController
                                      .userlist[e.donorindex].longitude),
                              tilt: 30.0,
                              zoom: 20,
                            )));
                            userController.userlistshown.value = false;
                          },
                          child: CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(.5),
                              radius: 12,
                              child: Icon(Icons.map,
                                  size: 15, color: Colors.redAccent))),
                      SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          _launchCaller(e);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(.5),
                          radius: 12,
                          child: Icon(
                            Icons.phone,
                            color: Colors.redAccent,
                            size: 15,
                          ),
                        ),
                      ),
                    ])))
                //DonorDetailsView(selelctedbloodgruop)
              ],
            ),
          ),
        AnimatedPositioned(
            bottom: pinPillPosition,
            right: 0,
            left: 0,
            duration: Duration(milliseconds: 200),
            child:
                pinPillPosition != -100 ? OntapUser(selectedUser) : Text('')),
        // Center(child: Text('Text("$pinPillPosition")')),
      ],
    );
  }

  void adduserMarker() {
    markers.add(Marker(
      icon: userIcon,
      markerId: MarkerId('sfe'),
      position: LatLng(
          userController.mylatitude.value, userController.mylongitude.value),
      consumeTapEvents: true,
      // infoWindow: InfoWindow(
      //     title: '${user.username}', snippet: "${user.userAddress}"),
      onTap: () {
        setState(() {
          pinPillPosition = 0;
        });
        // print(pinPillPosition);
      },
    ));
  }
}

class PinInformation {
  String pinPath;
  String avatarPath;
  LatLng location;
  String locationName;
  Color labelColor;
  PinInformation(
      {this.pinPath,
      this.avatarPath,
      this.location,
      this.locationName,
      this.labelColor});
}

class OntapUser extends StatelessWidget {
  OntapUser(this.user);
  final UserModel user;
  _launchCaller() async {
    String url = "tel:${user.phoneNo}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(DonorProfile(user: user));
      },
      child: FittedBox(
        child: Container(
            margin: const EdgeInsets.only(bottom: 30, left: 20, right: 70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white.withOpacity(.9),
            ),
            width: SizeConfig.screenWidth,
            height: 90,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(width: 5),
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage(user.photoUrl == '' ? noimage : user.photoUrl),
              ),
              SizedBox(width: 10),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Container(
                        width: 110,
                        child: Text(
                          user.username,
                          overflow: TextOverflow.clip,
                          style: smallText,
                        ),
                      ),
                    ),
                    Text(
                      user.userAddress,
                    ),
                    Text(
                      user.bloodgroup,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ]),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.more_horiz,
                              color: Colors.grey[700], size: 18)),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          _launchCaller();
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.green[200],
                            child: Icon(Icons.phone,
                                color: Colors.green[700], size: 15)),
                      )
                    ]),
              ),
              SizedBox(width: Defaults.paddingnormal),
            ])),
      ),
    );
  }
}

// class CustomMap extends StatelessWidget {
//   final controller = Get.find<HomeController>();
//   final List<Widget> _children = [
//     Container(),
//     GoogleMap(
//         mapType: MapType.hybrid,
//         // initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           // controller.animateCamera(CameraUpdate)
//           //  _controller.complete(controller);
//         },
//         initialCameraPosition: CameraPosition(
//             bearing: 192.8334901395799,
//             target: LatLng(37.43296265331129, -122.08832357078792),
//             tilt: 59.440717697143555,
//             zoom: 19.151926040649414)),
//     Container(),
//     Container(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Scaffold(
//         body: IndexedStack(
//           index: controller.selectedIndex.value,
//           children: _children,
//         ),
//         // bottomNavigationBar: BottomNavigationBar(
//         //   elevation: 0,
//         //   currentIndex: controller.count.value,
//         //   onTap: (v) {
//         //     controller.count.value = v;
//         //     if (v == 1) controller.ismap.toggle();
//         //   },
//         //   items: [
//         //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Request'),
//         //     controller.ismap.value
//         //         ? BottomNavigationBarItem(
//         //             icon: CircleAvatar(
//         //                 backgroundColor: controller.count.value == 1
//         //                     ? Colors.blue
//         //                     : Colors.grey,
//         //                 child: Icon(Icons.map)),
//         //             label: 'Map')
//         //         : BottomNavigationBarItem(
//         //             icon: CircleAvatar(
//         //                 backgroundColor: controller.count.value == 1
//         //                     ? Colors.blue
//         //                     : Colors.grey,
//         //                 child: Icon(Icons.list)),
//         //             label: 'List'),
//         //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account')
//         //   ],
//         // ),
//       ),
//     );
//   }
// }

// class KeepAlivePage extends StatefulWidget {
//   KeepAlivePage({
//     Key key,
//     @required this.child,
//   }) : super(key: key);

//   final Widget child;

//   @override
//   _KeepAlivePageState createState() => _KeepAlivePageState();
// }

// class _KeepAlivePageState extends State<KeepAlivePage>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   Widget build(BuildContext context) {
//     /// Dont't forget this
//     super.build(context);

//     return widget.child;
//   }

//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }
