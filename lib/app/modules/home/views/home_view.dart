import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/account/views/account_view.dart';
import 'package:flutter_blood_donation_app/app/modules/donation/controllers/donation_controller.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/custom_map.dart';
import 'package:flutter_blood_donation_app/app/modules/login/bindings/login_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/login/views/login_view.dart';
import 'package:flutter_blood_donation_app/app/modules/setting/bindings/setting_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/setting/views/setting_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/model/user_models.dart';
import '../controllers/home_controller.dart';

import 'request_widgets.dart';

List<PopupMenuItem> menuItem = [
  // PopupMenuItem(
  //   child: Text('Settings'),
  //   value: '/settings',
  // ),
  PopupMenuItem(
    child: Text('Signout'),
    value: '/login',
  ),
];

class HomeView extends GetView<HomeController> {
  final donationController = Get.put(DonationController());
  Widget buildBody(context) {
    switch (controller.selectedIndex.value) {
      case 2:
        return AccountView();

        break;
      case 1:
        return CustomMap();

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
                IconButton(
                    onPressed: () {
                      Get.to(SettingView(), binding: SettingBinding());
                    },
                    icon: Icon(Icons.settings)),
                IconButton(
                    onPressed: () {
                      authResult.signOut();
                      Get.offNamed('/login');
                    },
                    icon: Icon(Icons.logout))
                // PopupMenuButton(onSelected: (v) {
                //   // Get.snackbar(v, v);
                //   if (v == '/login') {
                //     FirebaseAuth.instance.signOut();
                //     Get.offAll(LoginView(), binding: LoginBinding());
                //   }
                // },
                // child: Icon(Icons.signout),
                //  itemBuilder: (context) {
                //   return List.generate(menuItem.length, (i) {
                //     return menuItem[i];
                //   });
                // }),
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
                    label: controller.userlistshown.value ? 'Map' : 'List'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Account'),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: controller.selectedIndex.value == 1
                ? Theme.of(context).scaffoldBackgroundColor
                : Colors.grey[300],
            onPressed: () {
              controller.selectedIndex.value = 1;
              if (controller.selectedIndex.value == 1) {
                controller.userlistshown.toggle();
              }
            },
            child: CircleAvatar(
              backgroundColor: controller.selectedIndex.value == 1
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              child: Icon(
                  controller.userlistshown.value ? Icons.map_sharp : Icons.list,
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
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
//map fix blood group sort
//user blood group
    return Obx(
      () => (homeController.requestData?.length ?? 0) != 0
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: homeController.requestData?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                if (Geolocator.distanceBetween( 
                        homeController.mylatitude.value,
                        homeController.mylongitude.value,
                        homeController.requestData[index].latitude,
                        homeController.requestData[index].longitude) <=
                    homeController.distance * 1000)
                  return UserRequest(
                      request: homeController.requestData[index]);

                return null;
              },
            )
          : Center(
              child: Text('No One Post Yet.',
                  style: TextStyle(color: Colors.grey)),
            ),
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
