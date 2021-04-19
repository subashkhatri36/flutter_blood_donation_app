import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/modules/splash/views/splash_view.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../login/views/login_view.dart';
import '../controllers/home_controller.dart';
import 'custom_map.dart';

class HomeView extends GetView<HomeController> {
  _launchCaller(String phone) async {
    String url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildBody(context) {
    double height = MediaQuery.of(context).size.height;
    switch (controller.selectedIndex.value) {
      case 0:
        return ListView.builder(
            //padding: EdgeInsets.symmetric(horizontal:5,vertical:10),
            shrinkWrap: true,
            itemBuilder: (_, int i) {
              return ListTile(
                contentPadding: EdgeInsets.only(left: 5, right: 5),
                title: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(.4),
                    ),
                    width: double.infinity,
                    height: 90,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5),
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://wallpaperaccess.com/full/2213424.jpg'),
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
                                Text('Lia'),
                                Text('Location '),
                                Text(
                                  'AB +',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                          Spacer(),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(LoginView(
                                      
                                    ));
                                  },
                                  child: CircleAvatar(
                                    radius: 11,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.grey[300],
                                        radius: 10,
                                        child: Icon(Icons.more_horiz,
                                            color: Colors.grey[700], size: 18)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchCaller('123456');
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Colors.green[200],
                                      radius: 11,
                                      child: RotatedBox(
                                          quarterTurns: 35,
                                          child: Icon(Icons.phone,
                                              color: Colors.green[700],
                                              size: 15))),
                                )
                              ]),
                          SizedBox(width: 10),
                        ])),
              );
            });
        break;
      case 1:
        return Column(children: [
          AppBar(
              title: Text('Blood Donation', style: TextStyle(fontSize: 14)),
              actions: [
                Icon(Icons.add_location_alt_rounded),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    Get.to(SplashView());
                  },
                )
              ]),
          Expanded(child: CustomMap())
        ]);
        break;
      case 2:
        return Container(
            alignment: Alignment.center,
            child: TextButton(
              child: Text(
                'Account',
                style:
                    TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.deepOrange),
              onPressed: () {},
            ));
        break;

      default:
        return Text('Page not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: buildBody(context),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 6,
            clipBehavior: Clip.antiAlias,
            child: BottomNavigationBar(
              onTap: (v) {
                controller.selectedIndex.value = v;
              },
              selectedItemColor: Theme.of(context).primaryColor,
              currentIndex: controller.selectedIndex.value,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.card_membership), label: 'Members'),
                BottomNavigationBarItem(icon: Icon(Icons.clear), label: 'map'),
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
            },
            child: CircleAvatar(
              backgroundColor: controller.selectedIndex.value == 1
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              child: Icon(Icons.map_sharp,
                  color: controller.selectedIndex.value == 1
                      ? Colors.white
                      : Colors.white),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ));
  }
}
