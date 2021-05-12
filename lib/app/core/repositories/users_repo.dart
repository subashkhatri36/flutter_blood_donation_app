import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:geocoding/geocoding.dart';

class UserReop {
  getmyinfo() async {
    var data = await firebaseFirestore
        .collection('User')
        .doc(authResult.currentUser.uid)
        .get();
    try {
      if (!data.exists) {
        UserModel user = UserModel(
            userId: authResult.currentUser.uid,
            userAddress: 'Balaju',
            email: 'user1@gmail.com',
            phoneNo: '12345678',
            latitude: 0.0,
            longitude: 0.0,
            bloodgroup: 'AB+');
        await firebaseFirestore
            .collection('Users')
            .doc(authResult.currentUser.uid)
            .set(user.toMap());
      } else {
        return UserModel.fromDocumentSnapshot(data);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getcoordinatefromAddress(String address) async {
    print(address);
    List<Location> locations = await locationFromAddress("$address,kathmandu");

    return locations;
  }

// get user from photo
  getUserwithPhotoUrl(String photo) async {
    List<UserModel> users = [];
    var data = await firebaseFirestore
        .collection('User')
        .where('photoUrl', isEqualTo: photo)
        .get();
    data.docs.forEach((element) {
      users.add(UserModel.fromDocumentSnapshot(element));
    });
    if (users.length != 0) return users[0];
  }

  getuser() async {
    List<UserModel> userlist = [];
    var data = await firebaseFirestore
        .collection('User')
        //  .where('userId', isNotEqualTo: auth.currentUser.uid)
        .get();
    data.docs.forEach((element) async {
      try {
        if (element.data()['userAddress'] == null ||
            element.data()['userAddress'] == '')
          firebaseFirestore
              .collection('User')
              .doc(element.id)
              .update({'userAddress': 'Gongabu'});
        else if (element.data()['latitude'] == 0.0 ||
            element.data()['latitude'] == null) {
          try {
            firebaseFirestore
                .collection('User')
                .doc(element.id)
                .update({'userAddress': 'Gongabu'});
            List<Location> data =
                await getcoordinatefromAddress(element.data()['userAddress']);
            firebaseFirestore.collection('User').doc(element.id).update(
                {'latitude': data[0].latitude, 'longitude': data[0].longitude});
          } catch (e) {
            print(e.toString());
          }
        } else {
          userlist.add(UserModel.fromDocumentSnapshot(element));
        }
      } catch (e) {}
    });

    return userlist;
  }
}

final userRepo = UserReop();
