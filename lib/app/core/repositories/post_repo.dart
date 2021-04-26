import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:get/get.dart';

class PostsRepo {
  final repo = firebaseFirestore.collection('request');

  sendRequest(req) async {
    String img = '';
    bool complete = false;

    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      img = value.data()['photoUrl'].toString();
    }).whenComplete(() => complete = true);

    if (complete) {
      if (img.isNotEmpty) req.userphotoUrl = img;
      req.timestamp = Timestamp.now();
      req.id = FirebaseAuth.instance.currentUser.uid;
      print(req.id);
      await repo
          .add(req.toMap())
          .then((value) => {print(value.id), Get.snackbar('Request', 'sent')})
          .catchError(
              // ignore: return_of_invalid_type_from_catch_error
              (onError) => {
                    print(onError.toString()),
                    Get.snackbar('Error', 'Failed to send request')
                  });
    }
  }

//get stream of request
  getRequest() {
    return repo
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<RequestModel> requests = [];
      query.docs.forEach((element) {
        //  print(element.id);
        // print()
        RequestModel rmodle = RequestModel.fromMap(element.data());
        rmodle.id = element.id;
        print(rmodle.id);
        // rmodle.timestamp = element['timestamp'];
        requests.add(rmodle);
        //print(element.data()['userphotoUrl']);
      });

      return requests;
    });
  }
}

final postRepo = PostsRepo();
