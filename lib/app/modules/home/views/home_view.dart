import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeController = Get.put(HomeController());
  BitmapDescriptor customIcon;
  BitmapDescriptor userIcon;
  Set<Marker> markers;
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
    //  ImageConfiguration configuration = createLocalImageConfiguration(context);
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
    setState(() {
      markers = Set.from([
        Marker(
          icon: customIcon,
          markerId: MarkerId('marker_123'),
          position: LatLng(47.6, 8.8796),
          consumeTapEvents: true,
          infoWindow: InfoWindow(
            title: 'PlatformMarker',
            snippet: "Hi I'm a Platform Marker",
          ),
          onTap: () {
            userMarker(context, 'assets/user.png');
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
        Marker(
          icon: customIcon,
          markerId: MarkerId('marker_12'),
          position: LatLng(47.60040882880962, 8.879983685910702),
          consumeTapEvents: true,
          infoWindow: InfoWindow(
            title: 'PlatformMarker',
            snippet: "Hi I'm a Platform Marker",
          ),
          onTap: () {
            print("Marker tapped");
          },
        )
      ]);
    });
  }

  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
  }

  Widget buildBody() {
    switch (homeController.selectedIndex.value) {
      case 0:
        return Container(
          child: Text('Members'),
        );
        break;
      case 1:
        break;
      case 2:
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    //addMarker();
    createMarker(context, 'assets/request.png');
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          AppBar(title: Text('Blood Donation'), actions: [
            Icon(Icons.add_location_alt_rounded),
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            )
          ]),
          Expanded(
            child: Container(
              height: height * .66,
              child: PlatformMap(
                initialCameraPosition: CameraPosition(
                  target: const LatLng(47.6, 8.8796),
                  zoom: 16.0,
                ),
                mapType: MapType.normal,
                markers: markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onTap: (pos) {
                  userMarker(context, 'assets/user.png');
                  print(pos);
                  Marker m = Marker(
                      markerId: MarkerId('1sfesfe'),
                      icon: userIcon,
                      position: pos);
                  setState(() {
                    markers.add(m);
                    print(markers.length);
                  });
                },
                onCameraMove: (cameraUpdate) {
                  print('onCameraMove: $cameraUpdate');
                  //createMarker(context);
                },
                compassEnabled: true,
                onMapCreated: (controller) {
                  Future.delayed(Duration(seconds: 2)).then(
                    (_) {
                      addMarker();
                      controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          const CameraPosition(
                            bearing: 270.0,
                            target: LatLng(47.6, 8.8796),
                            tilt: 30.0,
                            zoom: 18,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          onTap: (v) {
            homeController.selectedIndex.value = v;
          },
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: homeController.selectedIndex.value,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.card_membership), label: 'Requests'),
            BottomNavigationBarItem(icon: Icon(Icons.clear), label: 'map'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: homeController.selectedIndex.value == 1
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.grey[300],
        onPressed: () {
          homeController.selectedIndex.value = 1;
        },
        child: CircleAvatar(
          backgroundColor: homeController.selectedIndex.value == 1
              ? Theme.of(context).primaryColor
              : Colors.grey,
          child: Icon(Icons.map_sharp,
              color: homeController.selectedIndex.value == 1
                  ? Colors.white
                  : Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
