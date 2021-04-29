import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/donor_details_controller.dart';

class DonorDetailsView extends GetView<DonorDetailsController> {
  @override
  Widget build(BuildContext context) {
    
   List<UsermodelSortedtoMyLocationModel>user= controller.getDonors();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DonorList',
          style: largeText,
        ),
        actions: [
          IconButton(
              icon: Text(
                'AB -',
                style: mediumText.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
              onPressed: () {})
        ],
      ),
      body: //Obx(() => Text(controller.mylongitude.toString()))

           ListView.builder(
                itemCount: user.length,
                itemBuilder: (_, int i) {
                  //  return Text(userController.userlist.toList()[user[i].donorindex].username);})
                  return ListTile(
                      contentPadding: EdgeInsets.only(left: 5, right: 5),
                      title: SortedItem(user[i]));
                })
            // : Center(
            //     child: CircularProgressIndicator(
            //         backgroundColor: Theme.of(context).primaryColor),
            //   ),
     // ),
    );
  }
}

class SortedItem extends StatelessWidget {
  SortedItem(this.u, );
  final UsermodelSortedtoMyLocationModel u;
  _launchCaller() async {
    String url = "tel:${userController.userlist.toList()[u.donorindex].phoneNo}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){

      },
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(userController
                            .userlist.toList()[u.donorindex].photoUrl!=''?userController
                            .userlist.toList()[u.donorindex].photoUrl :noimage??
                        noimage) ,),
      title: Text(userController.userlist.toList()[u.donorindex].username.capitalize,),
      subtitle:Text(userController.userlist.toList()[u.donorindex].userAddress.capitalize,),
      trailing: Text("${u.distance/1000}km"),
    // return Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //       color: Colors.grey.withOpacity(.4),
    //     ),
    //     width: double.infinity,
    //     height: 120,
    //     child: Row(children: [
    //                Container(
    //         decoration: BoxDecoration(
    //             image: DecorationImage(
    //                 image: NetworkImage(userController
    //                         .userlist.toList()[u.donorindex].photoUrl!=''?userController
    //                         .userlist.toList()[u.donorindex].photoUrl :noimage??
    //                     noimage),
    //                 fit: BoxFit.cover),
    //             color: Colors.grey[600],
    //            borderRadius: BorderRadius.circular(55)
    //            ),
    //         height: 100,
    //         width: 100,
    //       ),
    //       SizedBox(
    //               width: 10,
    //             ),
    //            Column(
    //              mainAxisAlignment: MainAxisAlignment.center,
    //              children: [
    //               Text(userController.userlist.toList()[u.donorindex].username.capitalize,style: mediumText.copyWith(color:grey[600],fontWeight:FontWeight.bold),),
    //               Text(userController.userlist.toList()[u.donorindex].userAddress.capitalize,style: smallText.copyWith(color:grey[600],fontWeight:FontWeight.bold),),
    //            ],),
    //             Spacer(),
    //             Text("${u.distance/1000}km",style: smallText.copyWith(color:grey[700]),),
    //     ],),

  //         SizedBox(width: 10),
  //         Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //              // Text(userController.userlist.toList()[u.donorindex].photoUrl),
  //               Text(userController.userlist.toList()[u.donorindex].username),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Row(children: [
  //                 InkWell(
  //                   onTap: () {
  //                     //  Get.to(LoginView());
  //                   },
  //                   child: CircleAvatar(
  //                     radius: 16,
  //                     backgroundColor: Colors.grey,
  //                     child: CircleAvatar(
  //                         backgroundColor: Colors.grey[300],
  //                         radius: 15,
  //                         child: Icon(Icons.more_horiz,
  //                             color: Colors.grey[700], size: 18)),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 10,
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     _launchCaller();
  //                   },
  //                   child: CircleAvatar(
  //                       backgroundColor: Colors.green[200],
  //                       radius: 16,
  //                       child: RotatedBox(
  //                           quarterTurns: 35,
  //                           child: Icon(Icons.phone,
  //                               color: Colors.green[700], size: 15))),
  //                 )
  //               ]),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Row(
  //                 children: [
  //                   // Text((user[u.donorindex].rating[1] /
  //                   //         user[u.donorindex].rating[0])
  //                   //     .toString()),
  //                   for (int i = 1; i < 5; i++)
  //                     InkWell(
  //                       onTap: () {
  //                         // controller.favourite.value = i;
  //                         // print(controller.favourite.value);
  //                       },
  //                       // child: Obx(
  //                       //   () => controller.favourite.value == 0
  //                       //       ? Icon(i >= i ? Icons.star : Icons.star_border,
  //                       //           color: i >= i
  //                       //               ? Colors.deepOrange[400]
  //                       //               : Colors.grey)
  //                       //       : Text(''),
  //                       // ),
  //                     )
  //                 ],
  //               )
  //             ]),
  //         Spacer(),
  //         Column(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               // Expanded(child: Container()),
  //               Text("${u.distance/1000}km"),
  //               SizedBox(width: 10),
  //             ]),
  //         SizedBox(width: 10),
  //       ])
  // 
  );
   }
}
