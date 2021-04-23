import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:geocoding/geocoding.dart';

class UserReop {
  getmyinfo() async {
    var data = await firebaseFirestore
        .collection('User')
        .doc(auth.currentUser.uid)
        .get();
    try {
      if (!data.exists)

      // print(data.id);
      // if (data.data()['username'] == null)
      //   print(data.data()[
      //       'bloodgroud']); // if (data.data()['username'] == null || data.data()['username'])
      {
        print(false);
        UserModel user = UserModel(
            userId: auth.currentUser.uid,
            userAddress: 'Balaju',
            email: 'user1@gmail.com',
            phoneNo: '12345678',
            latitude: 0.0,
            longitude: 0.0,
            bloodgroup: 'AB+');
        await firebaseFirestore
            .collection('Users')
            .doc(auth.currentUser.uid)
            .set(user.toMap());
        print('completed');
      } else {
        // print(true);
        return UserModel.fromDocumentSnapshot(data);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getuser() async {
    List<UserModel> userlist = [];
    var data = await firebaseFirestore
        .collection('User')
        //  .where('userId', isNotEqualTo: auth.currentUser.uid)
        .get();
    data.docs.forEach((element) async {
      //  print(element.id);
      try {
        // print(element.data()['userAddress']);
        String str = element.data()['userAddress'];
        List arr = str.split('\\s');
        String word = arr[0];
        if (element.data()['latitude'] == 0.0 ||
            element.data()['latitude'] == null) {
          List<Location> data = await getcoordinatefromAddress(word);
          //print(data[0].latitude);
          firebaseFirestore.collection('User').doc(element.id).update(
              {'latitude': data[0].latitude, 'longitude': data[0].longitude});
        } else {
          userlist.add(UserModel.fromDocumentSnapshot(element));
        }
      } catch (e) {
        print(e.toString());
      }
    });
    return userlist;
  }

  getcoordinatefromAddress(String address) async {
    List<Location> locations = await locationFromAddress("$address,kathmandu");

    return locations;
  }
}

final userRepo = UserReop();
