import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/home_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/model/user_models.dart';

class CustomMap extends StatefulWidget {
  final bool zoomEnabled;
  final bool compassEnabled;

  const CustomMap({Key key, this.zoomEnabled, this.compassEnabled})
      : super(key: key);
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  // Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  BitmapDescriptor customIcon;
  BitmapDescriptor userIcon;
  Set<Marker> markers;
  UserModel selectedUser = UserModel(
      userId: '123',
      username: "User",
      userAddress: "Gongabu",
      latitude: 47.6,
      longitude: 8.8796,
      active: null,
      bloodgroup: '',
      email: '',
      phoneNo: '');

  double pinPillPosition = -100;
  // PinInformation currentlySelectedPin = PinInformation(
  //     pinPath: '',
  //     avatarPath: '',
  //     location: LatLng(27, 85),
  //     locationName: 'Ranibari',
  //     labelColor: Colors.grey);
  // PinInformation sourcePinInfo;
  // PinInformation destinationPinInfo;

  List<UserModel> users = [
    // UserModel(
    //     userId: '123',
    //     username: "User",
    //     userAddress: "Gongabu",
    //     latitude: 47.6,
    //     longitude: 8.8796,
    //     active: null,
    //     bloodgroup: '',
    //     email: '',
    //     phoneNo: ''),
    // UserModel(
    //     userId: '13',
    //     username: "User",
    //     userAddress: "Gongabu",
    //     latitude: 47.5999254766742,
    //     longitude: 8.879983685910702,
    //     active: null,
    //     bloodgroup: '',
    //     email: '',
    //     phoneNo: ''),
    // UserModel(
    //     userId: '12',
    //     username: "User",
    //     userAddress: "Gongabu",
    //     latitude: 47.60040882880962,
    //     longitude: 8.879983685910702,
    //     active: null,
    //     bloodgroup: '',
    //     email: '',
    //     phoneNo: ''),
    UserModel(
        userId: 'sfsk',
        phoneNo: '12323',
        username: 'Ram',
        active: null,
        bloodgroup: 'B+',
        email: '',
        latitude: 27.7493,
        longitude: 85.3213,
        userAddress: 'Gongabu',
        photoUrl: 'https://wallpaperaccess.com/full/2213424.jpg'),
    UserModel(
        userId: 'sfas',
        phoneNo: '12323',
        username: 'Sita',
        active: false,
        bloodgroup: 'AB-',
        email: '',
        latitude: 27.7325,
        longitude: 85.3177,
        userAddress: 'Ranibari',
        photoUrl:
            'https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
    UserModel(
        userId: 'sfk',
        phoneNo: '12323',
        username: 'Hari',
        active: null,
        bloodgroup: 'A+',
        email: '',
        latitude: 22,
        longitude: 22,
        userAddress: '',
        photoUrl:
            'https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'),
    UserModel(
        userId: 'sfkkk',
        phoneNo: '12323',
        username: 'Ramesh',
        active: null,
        bloodgroup: 'AB +',
        email: '',
        latitude: 32,
        longitude: 32,
        userAddress: '',
        photoUrl:
            'https://expertphotography.com/wp-content/uploads/2018/10/cool-profile-pictures-retouching-1.jpg'),
    UserModel(
        userId: 'sf',
        phoneNo: '12323',
        username: 'Shyam',
        active: null,
        bloodgroup: 'AB -',
        email: '',
        latitude: 33,
        longitude: 22,
        userAddress: '',
        photoUrl: 'https://i.stack.imgur.com/HILmr.png'),
  ];

  createMarker(context, image) {
    ImageConfiguration config =
        createLocalImageConfiguration(context, size: Size(10, 10));
    //  ImageConfiguration configuration = createLocalImageConfiguration(context);
    BitmapDescriptor.fromAssetImage(
      config,
      image,
    ).then((icon) {
      setState(() {
        customIcon = icon;
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
    // List<Marker> marker = [
    //   Marker(
    //     icon: customIcon,
    //     markerId: MarkerId('marker_123'),
    //     position: LatLng(47.6, 8.8796),
    //     consumeTapEvents: true,
    //     infoWindow: InfoWindow(
    //       title: 'DonorMarker',
    //       snippet: "Distance Platform Marker",
    //     ),
    //     onTap: () {
    //       userMarker(context, 'assets/images/user.png');
    //       //  print("Marker tapped");
    //     },
    //   ),
    //   Marker(
    //     icon: customIcon,
    //     markerId: MarkerId('marker_14'),
    //     position: LatLng(47.5999254766742, 8.880098685622215),
    //     consumeTapEvents: true,
    //     infoWindow: InfoWindow(
    //       title: 'PlatformMarker',
    //       snippet: "Hi I'm a Platform Marker",
    //     ),
    //     onTap: () {
    //       // print("Marker tapped");
    //     },
    //   ),
    // ];
    // Marker m = Marker(
    //     markerId: MarkerId('Mymarker'),
    //     icon: userIcon,
    //     position: LatLng(
    //         userController.mylongitude.value, userController.mylatitude.value));
    // setState(() {
    //   markers.add(m);
    // });
    // userController.userlist.forEach((element) {
    //  print(element.username);
    //   setState(() {
    //     markers.add(Marker(
    //       icon: userIcon,
    //       markerId: MarkerId('${element.userId}'),
    //        position: LatLng(element.latitude, element.longitude),
    //       consumeTapEvents: true,
    //       infoWindow: InfoWindow(
    //           title: 'MyMarker',
    //           snippet: "{element.userAddress + element.bloodgroup}"),
    //       onTap: () {
    //         setState(() {
    //           pinPillPosition = 0;
    //           selectedUser = userController.myinfo.value;
    //         });
    //         print(pinPillPosition);
    //       },
    //     ));
    //   }); //
    // });
  
  //set my marker
    setState(() {
      markers.add(Marker(
        icon: userIcon,
        markerId: MarkerId('${auth.currentUser.uid}'),
        position: LatLng(
            userController.mylatitude.value, userController.mylongitude.value),
        consumeTapEvents: true,
        infoWindow: InfoWindow(
            title: 'MyMarker',
            snippet: "{element.userAddress + element.bloodgroup}"),
        onTap: () {
          setState(() {
            pinPillPosition = 0;
            selectedUser = userController.myinfo.value;
          });
          print(pinPillPosition);
        },
      ));
    });
//to set usermarkers list
    users.forEach((element) {
      setState(() {
        markers.add(Marker(
          icon: customIcon,
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
            print(pinPillPosition);
          },
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //addMarker();
    createMarker(context, 'assets/images/request.png');
    userMarker(context, 'assets/images/defaultuser.png');
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
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
            //userMarker(context, 'assets/images/defaultuser.png');

            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    zoom: 16.0,
                    target: LatLng(userController.mylatitude.value,
                        userController.mylongitude.value))));
            // _controller.complete(controller);
          },
        ),
        // PlatformMap(
        //   initialCameraPosition: CameraPosition(
        //     target: const LatLng(47.6, 8.8796),
        //     zoom: 16.0,
        //   ),
        //   mapType: MapType.normal,
        //   markers: markers,
        //   myLocationEnabled: true,
        //   myLocationButtonEnabled: true,
        //   onTap: (pos) {
        //     print(pos);

        //     userMarker(context, 'assets/images/defaultuser.png');
        //     Marker m = Marker(
        //         markerId: MarkerId('1sfesfe'), icon: userIcon, position: pos);
        //     setState(() {
        //       markers.add(m);
        //       pinPillPosition == 0
        //           ? pinPillPosition = -100
        //           : pinPillPosition = 0;
        //       print(markers.length);
        //     });
        //   },
        //   // onCameraMove: (cameraUpdate) {
        //   //   print('onCameraMove: $cameraUpdate');
        //   //   //createMarker(context);
        //   // },
        //   // compassEnabled: true,
        //   // onMapCreated: (controller) {
        //   //   Future.delayed(Duration(seconds: 2)).then(
        //   //     (_) {
        //   //       addMarker();
        //   //       controller.animateCamera(
        //   //         CameraUpdate.newCameraPosition(
        //   //           const CameraPosition(
        //   //             bearing: 270.0,
        //   //             target: LatLng(47.6, 8.8796),
        //   //             //tilt: 10,
        //   //             zoom: 10,
        //   //             tilt: 30.0,
        //   //             //  zoom: 16,
        //   //           ),
        //   //         ),
        //   //       );
        //   //     },
        //   //   );
        //  // },
        // ),
        AnimatedPositioned(
            bottom: pinPillPosition,
            right: 0,
            left: 0,
            duration: Duration(milliseconds: 200),
            child: pinPillPosition != -100 ? TappedUser(selectedUser) : Text('')

            // Container(
            //     margin: EdgeInsets.only(left: 20, bottom: 30, right: 20),
            //     padding: EdgeInsets.only(left: 30),
            //     height: 70,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(20),
            //       boxShadow: [
            //         BoxShadow(
            //             blurRadius: 20,
            //             offset: Offset.zero,
            //             color: Colors.grey.withOpacity(.5))
            //       ],
            //     ),
            //     child: MemberInfo(selectedUser)

            //  Row(
            //   children: [
            //     Container(
            //       height: 70,
            //       width: 70,
            //       child:
            //           ClipOval(child: Image.network(selectedUser.photoUrl)),
            //     ),
            //     Expanded(
            //       child: Column(
            //         children: [
            //           Text(selectedUser.username),
            //           Text(selectedUser.userAddress),
            //           Text(selectedUser.bloodgroup)
            //         ],
            //       ),
            //     ),
            //    Column(children: [Icon(Icons.close), Text('4.4km')]),
            //  ],
            //   )

            // )
            )
      ],
    );
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

class TappedUser extends StatelessWidget {
  TappedUser(this.user);
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
    return Container(
        margin: const EdgeInsets.only(bottom: 30, left: 20, right: 70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(.9),
        ),
        width: double.infinity,
        height: 90,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(user.photoUrl), fit: BoxFit.cover),
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(5)),
            height: 80,
            width: 80,
          ),
          SizedBox(width: 10),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: largeText,
                ),
                Text(
                  user.userAddress,
                ),
                Text(
                  user.bloodgroup,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )
              ]),
          Spacer(),
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            CircleAvatar(
              radius: 11,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 10,
                  child: Icon(Icons.more_horiz,
                      color: Colors.grey[700], size: 18)),
            ),
            InkWell(
              onTap: () {
                _launchCaller();
              },
              child: CircleAvatar(
                  backgroundColor: Colors.green[200],
                  radius: 11,
                  child: RotatedBox(
                      quarterTurns: 35,
                      child: Icon(Icons.phone,
                          color: Colors.green[700], size: 15))),
            )
          ]),
          SizedBox(width: Defaults.paddingnormal),
        ]));
  }
}
