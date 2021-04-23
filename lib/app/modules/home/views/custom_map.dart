import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

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
  BitmapDescriptor customIcon;
  BitmapDescriptor userIcon;
  Set<Marker> markers;

  List<UserModel> users = [
    UserModel(
        userId: '123',
        username: "User",
        userAddress: "Gongabu",
        latitude: 47.6,
        longitude: 8.8796,
        active: null,
        bloodgroup: '',
        email: '',
        phoneNo: ''),
    UserModel(
        userId: '13',
        username: "User",
        userAddress: "Gongabu",
        latitude: 47.5999254766742,
        longitude: 8.879983685910702,
        active: null,
        bloodgroup: '',
        email: '',
        phoneNo: ''),
    UserModel(
        userId: '12',
        username: "User",
        userAddress: "Gongabu",
        latitude: 47.60040882880962,
        longitude: 8.879983685910702,
        active: null,
        bloodgroup: '',
        email: '',
        phoneNo: ''),
    UserModel(
        userId: 'sfsk',
        phoneNo: '12323',
        username: 'Ram',
        active: null,
        bloodgroup: '',
        email: '',
        latitude: 22,
        longitude: 32,
        userAddress: '',
        photoUrl: 'https://wallpaperaccess.com/full/2213424.jpg'),
    UserModel(
        userId: 'sfas',
        phoneNo: '12323',
        username: 'Sita',
        active: false,
        bloodgroup: '',
        email: '',
        latitude: 23,
        longitude: 77,
        userAddress: 'B',
        photoUrl:
            'https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
    UserModel(
        userId: 'sfk',
        phoneNo: '12323',
        username: 'Hari',
        active: null,
        bloodgroup: 'A',
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
    List<Marker> marker = [
      Marker(
        icon: customIcon,
        markerId: MarkerId('marker_123'),
        position: LatLng(47.6, 8.8796),
        consumeTapEvents: true,
        infoWindow: InfoWindow(
          title: 'DonorMarker',
          snippet: "Distance Platform Marker",
        ),
        onTap: () {
          userMarker(context, 'assets/images/user.png');
          print("Marker tapped");
        },
      ),
      Marker(
        icon: customIcon,
        markerId: MarkerId('marker_14'),
        position: LatLng(47.5999254766742, 8.880098685622215),
        consumeTapEvents: true,
        infoWindow: InfoWindow(
          title: 'PlatformMarker',
          snippet: "Hi I'm a Platform Marker",
        ),
        onTap: () {
          print("Marker tapped");
        },
      ),
    ];
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
            print("Marker tapped");
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
    return PlatformMap(
      initialCameraPosition: CameraPosition(
        target: const LatLng(47.6, 8.8796),
        zoom: 16.0,
      ),
      mapType: MapType.normal,
      markers: markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onTap: (pos) {
        print(pos);
        userMarker(context, 'assets/images/defaultuser.png');
        Marker m = Marker(
            markerId: MarkerId('1sfesfe'), icon: userIcon, position: pos);
        setState(() {
          markers.add(m);
          print(markers.length);
        });
      },
      onCameraMove: (cameraUpdate) {
        print('onCameraMove: $cameraUpdate');
        //createMarker(context);
      },
      // compassEnabled: true,
      onMapCreated: (controller) {
        Future.delayed(Duration(seconds: 2)).then(
          (_) {
            addMarker();
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                const CameraPosition(
                  bearing: 270.0,
                  target: LatLng(47.6, 8.8796),
                  //tilt: 10,
                  zoom: 10,
                  tilt: 30.0,
                  //  zoom: 16,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
