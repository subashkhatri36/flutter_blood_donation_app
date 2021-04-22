import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/account/bindings/account_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/account/views/account_view.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/model/user_models.dart';
import '../../login/views/login_view.dart';
import '../controllers/home_controller.dart';
import 'custom_map.dart';
import 'request_widgets.dart';

class HomeView extends GetView<HomeController> {
  Widget buildBody(context) {
    //double height = MediaQuery.of(context).size.height;
    switch (controller.selectedIndex.value) {
      case 2:
        return ListView.builder(
            //padding: EdgeInsets.symmetric(horizontal:5,vertical:10),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (_, int i) {
              return ListTile(
                  contentPadding: EdgeInsets.only(left: 5, right: 5),
                  title: MemberInfo(controller.user[i]));
            });
        break;
      case 1:
        return Column(children: [
          Expanded(
              child: Stack(
            children: [
              CustomMap(),
            ],
          )),
        ]);
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
          appBar: AppBar(
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/logoapp.png',
                    height: 60,
                    width: 70,
                  ),
                  // Text('Blood Donation', style: smallText),
                ],
              ),
              actions: [
                // Icon(Icons.add_location_alt_rounded),

                IconButton(
                  icon: Icon(Icons.account_box_rounded),
                  onPressed: () {
                    Get.to(() => AccountView(), binding: AccountBinding());
                  },
                )
              ]),
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
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.clear), label: 'Map'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.card_membership), label: 'Members'),
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

class RequestsHome extends StatelessWidget {
  const RequestsHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return ListView(
      children: [...homeController.user.map((e) => UserRequest(user: e))],
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
          color: Colors.grey.withOpacity(.4),
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
                Text('Lia'),
                Text('Location '),
                Text(
                  'AB +',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )
              ]),
          Spacer(),
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            InkWell(
              onTap: () {
                Get.to(LoginView());
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
