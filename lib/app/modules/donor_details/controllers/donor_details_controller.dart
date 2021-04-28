import 'dart:math';

import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class DonorDetailsController extends GetxController {
  var loading = false.obs;
  var count = 0.obs;
  // var mylatitude = 27.0.obs;
  // var mylongitude = 85.0.obs;
  var favourite = 0.obs;
  var donorlist =
      List<UsermodelSortedtoMyLocationModel>.empty(growable: true).obs;
  var userlist = List<UserModel>.empty(growable: true).obs;

  //geocoding
  getcoordinatefromAddress(String address) async {
    List<Location> locations = await locationFromAddress("$address,kathmandu");

    return locations[0];
  }

  getuser() async {
  userlist=  userController.userlist;
    // var data = await firebaseFirestore.collection('User').get();
    // data.docs.forEach((element) async {
    //   //print(element.id);
    //   if (element.data()['userAddress'] == '' ||
    //       element.data()['userAddress'] == null) {
    //     bool updated = false;
    //     await firebaseFirestore.collection('User').doc(element.id).update(
    //         {'userAddress': 'Basundhara'}).then((value) => updated == true);
    //     if (true) {
    //       Get.snackbar('updated', 'Completed');
    //     }
    //   } else {
    //     userlist.add(UserModel.fromDocumentSnapshot(element));
    //   }
    // });
    getDonors();

    //print(userlist.length);
  }

  @override
  void onInit() {
    super.onInit();
   // getPosition();
//getDonors();
    //getcoordinatefromAddress();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  // getPosition() async {
  //   loading.value = true;
  //   await Geolocator.getCurrentPosition().then((location) {
  //     mylatitude.value = location.latitude;
  //     mylongitude.value = location.longitude;
  //   });

  //   getuser();
  // }

  getDonors()  {List distance=[];
     List<UsermodelSortedtoMyLocationModel> mylist = [];
     List<UserModel> users=userController.userlist.toList();
    users.forEach((element)  {
      // if (element.userAddress == null) {
      //   firebaseFirestore
      //       .collection('User')
      //       .doc(element.userId)
      //       .update({'userAddress': 'Basundhara'});
      // }

      // var loc = await getcoordinatefromAddress(element.userAddress);
      //print(loc.latitude);

      UsermodelSortedtoMyLocationModel mod = UsermodelSortedtoMyLocationModel()
        ..distance = Geolocator.distanceBetween(userController.mylatitude.value,
                userController.mylongitude.value, element.latitude, element.longitude)
            .truncate()
           
        ..name = element.username
        ..donorindex = users.indexOf(element);
     
      // distance.add(mod.distance);
     
      mylist.add(mod);
    });
  // distance.sort();
  // distance.forEach((element) {print(distance);});
  mylist.sort((a,b)=>a.distance.compareTo(b.distance));
  // mylist.forEach((element) {print(element.donorindex);});
 // donorlist=mylist.obs;
  //  donorlist.toList().sort((a, b) => a.distance.compareTo(b.distance));
    //donorlist.forEach((element) {print(element.distance);});
    //loading.value = false;
return mylist;}

  //vincinety
  double getVincentyDistance(
      double lat1, double lon1, double lat2, double lon2) {
    double a = 6378137, b = 6356752.314245, f = 1 / 298.257223563;
    double L = 22 / 7 / 180 * (lon2 - lon1);

    double u1 = atan((1 - f) * tan(22 / 7 / 180 * (lat1)));

    double u2 = atan((1 - f) * tan(22 / 7 / 180 * (lat2)));

    double sinU1 = sin(u1), cosU1 = cos(u1);

    double sinU2 = sin(u2), cosU2 = cos(u2);

    double cosSqAlpha, sinSigma, cos2SigmaM, cosSigma, sigma;

    double lambda = L, lambdaP, iterLimit = 100;

    do {
      double sinLambda = sin(lambda), cosLambda = cos(lambda);

      sinSigma = sqrt((cosU2 * sinLambda) * (cosU2 * sinLambda) +
          (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda) *
              (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda));

      if (sinSigma == 0) return 0;

      cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLambda;

      sigma = atan2(sinSigma, cosSigma);

      double sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma;

      cosSqAlpha = 1 - sinAlpha * sinAlpha;

      cos2SigmaM = cosSigma - 2 * sinU1 * sinU2 / cosSqAlpha;

      double C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha));

      lambdaP = lambda;

      lambda = L +
          (1 - C) *
              f *
              sinAlpha *
              (sigma +
                  C *
                      sinSigma *
                      (cos2SigmaM +
                          C * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));
    } while ((lambda - lambdaP).abs() > 1e-12 && --iterLimit > 0);

    if (iterLimit == 0) return 0;

    double uSq = cosSqAlpha * (a * a - b * b) / (b * b);

    double A =
        1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
    double B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));
    double deltaSigma = B *
        sinSigma *
        (cos2SigmaM +
            B /
                4 *
                (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) -
                    B /
                        6 *
                        cos2SigmaM *
                        (-3 + 4 * sinSigma * sinSigma) *
                        (-3 + 4 * cos2SigmaM * cos2SigmaM)));
    double s = b * A * (sigma - deltaSigma);
    return s / 1000.toInt();
  }
}

class UsermodelSortedtoMyLocationModel {
  int distance;
  String name;
  int donorindex;

  UsermodelSortedtoMyLocationModel({this.distance, this.name, this.donorindex});
}
