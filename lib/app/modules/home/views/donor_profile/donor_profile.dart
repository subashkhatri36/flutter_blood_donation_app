import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';

class DonorProfile extends StatelessWidget {
  DonorProfile({this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          DonorProfileHeader(user: user),
          Container(
            color: Colors.grey[300],
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Schedule New Appoinment'),
                  subtitle: Text('Choose time and location and donation type'),
                ),
                ListTile(
                    leading: CircleAvatar(),
                    title: Text('Schedule New Appoinment'),
                    subtitle:
                        Text('Choose time and location and donation type')),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            color: Colors.grey[300].withOpacity(.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Address',
                    style: mediumText,
                  ),
                  subtitle: Text('Ranibari, Kathmandu'),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Email',
                    style: mediumText,
                  ),
                  subtitle: Text('s@gmail.com'),
                ),
                Divider(),
                // ListTile(
                //   title: Text(
                //     'Contact',
                //     style: mediumText,
                //   ),
                //   subtitle: Text('0542131'),
                // ),
                ListTile(
                  title: Text(
                    '984276234',
                    style: mediumText,
                  ),
                  subtitle: Text('Ranibari, Kathmandu'),
                  trailing: InkWell(onTap: () {}, child: Icon(Icons.phone)),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Last Donations',
                    style: largeText.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Wednesday , August 4 ,2019'),
                ),
                Container(
                  height: 180,
                  color: Colors.grey[400].withOpacity(.5),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Card(
                          child: Icon(Icons.water_damage),
                        ),
                        title: Text('2 Dontations(Year to Date)'),
                        subtitle: Text('Blood'),
                      ),
                      ListTile(
                        leading: Card(
                          child: Icon(Icons.water_damage),
                        ),
                        title: Text('2 Dontations(Year to Date)'),
                        subtitle: Text('Blood'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'All Donations',
                    style: largeText.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Wednesday , August 4 ,2019'),
                ),
                Container(
                  height: 180,
                  color: Colors.grey[400].withOpacity(.5),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Card(
                          child: Icon(Icons.water_damage),
                        ),
                        title: Text('2 Dontations(Year to Date)'),
                        subtitle: Text('Blood'),
                      ),
                      ListTile(
                        leading: Card(
                          child: Icon(Icons.water_damage),
                        ),
                        title: Text('2 Dontations(Year to Date)'),
                        subtitle: Text('Blood'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DonorProfileHeader extends StatelessWidget {
  final UserModel user;
  const DonorProfileHeader({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        //padding: EdgeInsets.only(left: 20),
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Container(height: 130, color: Colors.white),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 62,
                backgroundColor: Colors.green,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user.photoUrl ?? noimage),
                ),
              ),
            ),
            Align(
              child: Column(
                children: [],
              ),
            )
            //Container(height: 100, color: Colors.white),
            //   Positioned(
            //     child: Container(
            //       height: 100,
            //       child: Row(
            //         children: [
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               CircleAvatar(
            //                 backgroundImage: NetworkImage(noimage),
            //               ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //               Text(
            //                 'Sudarshan',
            //                 style: largeText.copyWith(color: Colors.white),
            //               ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //             ],
            //           ),
            //           Spacer(),
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               Text(
            //                 'Blood Type',
            //                 style: mediumText.copyWith(color: Colors.white),
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text(
            //                 '0+',
            //                 style: largeText.copyWith(color: Colors.white),
            //               ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               Text(
            //                 'Units Dontaed',
            //                 style: mediumText.copyWith(color: Colors.white),
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text(
            //                 '0+',
            //                 style: largeText.copyWith(color: Colors.white),
            //               ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //   )
          ],
        ));
  }
}
