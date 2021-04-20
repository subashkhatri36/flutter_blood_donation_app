import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../core/model/user_models.dart';
import '../../login/views/login_view.dart';
import '../controllers/home_controller.dart';
import 'custom_map.dart';
import 'request_widgets.dart';

final grey = Colors.grey;
List<UserModel> user = [
  UserModel(
      userId: 'sfs',
      phoneNo: '12323',
      username: 'Ram',
      active: null,
      bloodgroup: '',
      email: '',
      latitude: null,
      longitude: null,
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
      userId: 'sf',
      phoneNo: '12323',
      username: 'Hari',
      active: null,
      bloodgroup: 'A',
      email: '',
      latitude: null,
      longitude: null,
      userAddress: '',
      photoUrl:
          'https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'),
  UserModel(
      userId: 'sf',
      phoneNo: '12323',
      username: 'Ramesh',
      active: null,
      bloodgroup: 'AB +',
      email: '',
      latitude: null,
      longitude: null,
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
      latitude: null,
      longitude: null,
      userAddress: '',
      photoUrl: 'https://i.stack.imgur.com/HILmr.png'),
];

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
                  title: MemberInfo(user[i]));
            });
        break;
      case 1:
        return Column(children: [
          AppBar(
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/logoapp.png',
                    height: 50,
                    width: 70,
                  ),
                 // Text('Blood Donation', style: smallText),
                ],
              ),
              actions: [
               // Icon(Icons.add_location_alt_rounded),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    Get.offNamed('/request');
                  },
                )
              ]),
          Expanded(
              child: Stack(
            children: [
              CustomMap(),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 8.0),
              //   child: Align(
              //       alignment: Alignment.bottomRight,
              //       child: RotatedBox(
              //         quarterTurns: -45,
              //         child: FloatingActionButton.extended(
              //           backgroundColor: Theme.of(context).primaryColor,
              //           onPressed: () {
              //             Get.toNamed('/request');
              //           },
              //           shape: RoundedRectangleBorder(
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(10.0))),
              //           label: Text(
              //             'Request',
              //             style: smallText,
              //           ),
              //         ),
              //       )),
              // ),
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
                  : grey,
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
    double height = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        AppBar(title: Text(' Requests')),
        ...user.map((e) => UserRequest(user: e))
        // TextButton(
        //   child: Text(
        //     'Account',
        //     style:
        //         TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
        //   ),
        //   style: TextButton.styleFrom(backgroundColor: Colors.deepOrange),
        //   onPressed: () {},
        // )
      ],
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
          color: grey.withOpacity(.4),
        ),
        width: double.infinity,
        height: 90,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(user.photoUrl), fit: BoxFit.cover),
                color: grey[600],
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
                backgroundColor: grey,
                child: CircleAvatar(
                    backgroundColor: grey[300],
                    radius: 10,
                    child: Icon(Icons.more_horiz, color: grey[700], size: 18)),
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
          SizedBox(width: 10),
        ]));
  }
}
