import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/account/views/account_view.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/model/user_models.dart';
import '../controllers/home_controller.dart';
import 'custom_map.dart';
import 'request_widgets.dart';

// List<RequestModel> request = [
//   RequestModel(
//       id: '1',
//       name: 'Ram',
//       bloodgroup: 'B+',
//       detail: 'Detail',
//       address: 'Ranibari',
//       photoUrl: '',
//       timestamp: Timestamp.now()),
//   RequestModel(
//       id: '1',
//       name: 'Ram',
//       bloodgroup: 'B+',
//       detail: 'Detail',
//       address: 'Ranibari',
//       timestamp: Timestamp.now()),
//   RequestModel(
//       id: '1',
//       name: 'ram',
//       bloodgroup: 'B+',
//       detail: 'Detail',
//       address: 'Ranibari',
//       timestamp: Timestamp.now()),
// ];
List<PopupMenuItem> menuItem = [
  // PopupMenuItem(
  //   child: Text('Request Blood'),
  //   value: '/request',
  // ),
  // PopupMenuItem(
  //   child: Text('Home'),
  //   value: '/home',
  // ),
  //
  PopupMenuItem(
    child: Text('Donors available'),
    value: '/donor-details',
  ),
  // PopupMenuItem(
  //   child: Text('Account'),
  //   value: '/account',
  // ),
  // PopupMenuItem(
  //   child: Text('Settings'),
  //   value: '/settings',
  // ),
  PopupMenuItem(
    child: Text('Signout'),
    value: '/login',
  ),
];

// List<UserModel> users = [
//   UserModel(
//       userId: 'sfs',
//       phoneNo: '12323',
//       username: 'ram',
//       active: null,
//       bloodgroup: 'B +',
//       email: '',
//       latitude: 22,
//       longitude: 32,
//       userAddress: '',
//       photoUrl: 'https://wallpaperaccess.com/full/2213424.jpg'),
//   UserModel(
//       userId: 'sfas',
//       phoneNo: '12323',
//       username: 'Sita',
//       active: false,
//       bloodgroup: 'A -',
//       email: '',
//       latitude: 23,
//       longitude: 77,
//       userAddress: 'B',
//       photoUrl:
//           'https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
//   UserModel(
//       userId: 'sf',
//       phoneNo: '12323',
//       username: 'Hari',
//       active: null,
//       bloodgroup: 'A +',
//       email: '',
//       latitude: 22,
//       longitude: 22,
//       userAddress: '',
//       photoUrl:
//           'https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'),
//   UserModel(
//       userId: 'sf',
//       phoneNo: '12323',
//       username: 'Ramesh',
//       active: null,
//       bloodgroup: 'AB +',
//       email: '',
//       latitude: 32,
//       longitude: 32,
//       userAddress: '',
//       photoUrl:
//           'https://expertphotography.com/wp-content/uploads/2018/10/cool-profile-pictures-retouching-1.jpg'),
//   UserModel(
//       userId: 'sf',
//       phoneNo: '12323',
//       username: 'Shyam',
//       active: null,
//       bloodgroup: 'AB -',
//       email: '',
//       latitude: 33,
//       longitude: 22,
//       userAddress: '',
//       photoUrl: 'https://i.stack.imgur.com/HILmr.png'),
// ];

class HomeView extends GetView<HomeController> {
  Widget buildBody(context) {
    //double height = MediaQuery.of(context).size.height;
    switch (controller.selectedIndex.value) {
      case 2:
        return AccountView();

        break;
      case 1:
        return

            // Obx(() => userController.userlistshown.value
            //     ? ListView.builder(
            //         //padding: EdgeInsets.symmetric(horizontal:5,vertical:10),
            //         shrinkWrap: true,
            //         itemCount: 5,
            //         itemBuilder: (_, int i) {
            //           return ListTile(
            //               onTap: () {
            //                 Get.to(Scaffold());
            //               },
            //               contentPadding: EdgeInsets.only(left: 5, right: 5),
            //               title: MemberInfo(userController.userlist.toList()[i]));
            //         })
            // : Container());
            CustomMap();

        break;
      case 0:
        return RequestsHome();
        break;

      default:
        return Text('Page not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/logoapp.png',
                    height: 60,
                    width: 70,
                  ),
                ],
              ),
              actions: [
                InkWell(
                    onTap: () {
                      Get.offNamed('/request');
                    },
                    child: Icon(Icons.add_location_alt_rounded)),
                PopupMenuButton(onSelected: (v) {
                  // Get.snackbar(v, v);
                  if (v == '/login') {
                    userController.signout();
                  }
                  Get.toNamed(v);
                }, itemBuilder: (context) {
                  return List.generate(menuItem.length, (i) {
                    return menuItem[i];
                  });
                }),
              ]),
          body: buildBody(context),
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            shape: CircularNotchedRectangle(),
            notchMargin: 3,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: BottomNavigationBar(
              onTap: (v) {
                print(v);
                controller.selectedIndex.value = v;

                controller.userlistshown.value = true;
              },
              selectedItemColor: Theme.of(context).primaryColor,
              currentIndex: controller.selectedIndex.value,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Requests'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.clear),
                    label: controller.userlistshown.value ? 'Map' : 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Account'),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: controller.selectedIndex.value == 1
                ?
                // ? controller.userlistshown.value
                //     ?
                Theme.of(context).scaffoldBackgroundColor
                : Colors.grey[300],
            // : Colors.grey[300],
            onPressed: () {
              controller.selectedIndex.value = 1;
              if (controller.selectedIndex.value == 1)
                controller.userlistshown.toggle();
            },
            child: CircleAvatar(
              backgroundColor: controller.selectedIndex.value == 1
                  ?
                  // ? !controller.userlistshown.value
                  //     ? Theme.of(context).primaryColor
                  Theme.of(context).primaryColor
                  : Colors.white,
              child: Icon(
                  controller.userlistshown.value ? Icons.list : Icons.map_sharp,
                  color: controller.userlistshown.value
                      ? Colors.grey
                      : Colors.white),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ));
  }
}

class RequestsHome extends StatelessWidget {
  const RequestsHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
//map fix blood group sort
//user blood group
    return Obx(
      () => !homeController.loading.value
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: homeController.requestData.length,
              itemBuilder: (BuildContext context, int index) {
                return UserRequest(request: homeController.requestData[index]);

                // Container(
                //   height: 100,
                //   color: Colors.red,
                //   child: Image.memory(
                //     base64Decode(homeController.requestData[index].photoUrl),
                //     fit: BoxFit.fill,
                //   ),
                // );
              },
            )
          : CircularProgressIndicator(),
    );
  }
}

class MemberInfo extends StatelessWidget {
  MemberInfo(this.user);
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
                borderRadius: BorderRadius.circular(1)),
            height: 60,
            width: 80,
          ),
          SizedBox(width: 20),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username.capitalize,
                  style: largeText.copyWith(
                      color: Colors.grey[600], fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 5),
                Text(
                  user.userAddress,
                  style: mediumText.copyWith(color: Colors.grey),
                ),
                Text(
                  user.bloodgroup,
                  style: largeText.copyWith(
                      fontSize: 24,
                      color: Colors.red.shade900,
                      fontWeight: FontWeight.bold),
                ),
              ]),
          Spacer(),
          InkWell(
              onTap: () {
                _launchCaller();
              },
              child: CircleAvatar(
                backgroundColor: Colors.green[200],
                child: Icon(Icons.phone, color: Colors.green[700], size: 15),
              )),
          SizedBox(width: Defaults.paddingnormal),
        ]));
  }
}
