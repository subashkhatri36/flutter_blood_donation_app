import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/model/user_models.dart';
import '../../../utlis/size_config.dart';

class CustomMap extends StatefulWidget {
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  // Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  BitmapDescriptor customIcon;
  BitmapDescriptor userIcon;
  List<BitmapDescriptor> mapicons = [];
  Set<Marker> markers;
  double mylatitude;
  double mylongitude;
  UserModel selectedUser;

  double pinPillPosition = -100;
  List<UserModel> users = [];
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
    users.forEach((element) {
      //print(bloodgroup.indexOf(element.bloodgroup));
      if (element.userId != userController.myinfo.value.userId)
        markers.add(Marker(
          icon: mapicons[bloodgroup.indexOf(element.bloodgroup)],
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
          },
        ));
    });
  }

  @override
  void initState() {
    super.initState();

    markers = Set.from([]);
    setUser();
    selectedUser = userController.myinfo.value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  setUser() {
    setState(() {
      users = userController.userlist;
    });
  }

  createmarker(context) {
    bloodicons.forEach((element) {
      // print(element);
      //
      createIcon(context, element);

      //createMarker(context, element);
    });
  }

  @override
  Widget build(BuildContext context) {
    //  createMarker(context, 'assets/images/request.png');
    // userMarker(context, 'assets/images/defaultuser.png');
    createmarker(context);
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
        AnimatedPositioned(
            bottom: pinPillPosition,
            right: 0,
            left: 0,
            duration: Duration(milliseconds: 200),
            child:
                pinPillPosition != -100 ? TappedUser(selectedUser) : Text(''))
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
        print(pinPillPosition);
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
    return FittedBox(
      child: Container(
          margin: const EdgeInsets.only(bottom: 30, left: 20, right: 70),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(.9),
          ),
          width: SizeConfig.screenWidth,
          height: 90,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(width: 5),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          user.photoUrl == '' ? noimage : user.photoUrl),
                      fit: BoxFit.cover),
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
                  Container(
                    width: 140,
                    child: Text(
                      user.username,
                      overflow: TextOverflow.clip,
                      style: smallText,
                    ),
                  ),
                  Text(
                    user.userAddress,
                  ),
                  Text(
                    user.bloodgroup,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                ]),
            Spacer(),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              // CircleAvatar(
              //   backgroundColor: Colors.grey,
              //   child: CircleAvatar(
              //       backgroundColor: Colors.grey[300],
              //       radius: 10,
              //       child: Icon(Icons.more_horiz,
              //           color: Colors.grey[700], size: 18)),
              // ),
              InkWell(
                onTap: () {
                  _launchCaller();
                },
                child: CircleAvatar(
                    backgroundColor: Colors.green[200],
                    child:
                        Icon(Icons.phone, color: Colors.green[700], size: 15)),
              )
            ]),
            SizedBox(width: Defaults.paddingnormal),
          ])),
    );
  }
}
