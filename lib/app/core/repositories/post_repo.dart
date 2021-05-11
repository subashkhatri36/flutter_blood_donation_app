import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class PostsRepo {
  final repo = firebaseFirestore.collection('request');
  sendRequest(RequestModel req) async {
    print(req.toJson());
    await repo
        .add(req.toJson())
        .then((value) => {
              //print(value.id),
              Get.snackbar('Request', 'sent')
            })
        .catchError(
            // ignore: return_of_invalid_type_from_catch_error
            (onError) => {
                  print(onError.toString()),
                  Get.snackbar('Error', 'Failed to send request')
                });
  }

//get stream of request
  getRequest() {
    return repo
        .orderBy('timestamp', descending: true)

        //.limit(3)
        .snapshots()
        .map((QuerySnapshot query) {
      List<RequestModel> requests = [];
      query.docs.forEach((element) {
        requests.add(RequestModel.fromDocumentSnapshot(element));
      });

      return requests;
    });
  }

  mybloodrequest() {
    return repo
        .where('userid', isEqualTo: userController.myinfo.value.userId)
        .snapshots()
        .map((event) {
      List<RequestModel> requests = [];
      event.docs.forEach((element) {
        requests.add(RequestModel.fromDocumentSnapshot(element));
      });

      return requests;
    });
  }
}

final postRepo = PostsRepo();
