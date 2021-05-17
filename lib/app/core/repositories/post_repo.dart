import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class PostsRepo {
  String notificationUrl = 'https://fcm.googleapis.com/fcm/send';
  sendNotification(String userId, List<UserModel> userList) async {
    try {} catch (error) {
      print(error);
    }
  }

  final repo = firebaseFirestore.collection('request');
  sendRequest(RequestModel req) async {
    // print(req.toJson());
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
        .snapshots(includeMetadataChanges: true)
        .map((QuerySnapshot query) {
      List<RequestModel> requests = [];
      query.docs.forEach((element) {
        // print(element);
        if (element.data()['status'] == 'waiting')
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
        requests.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      });

      return requests;
    });
  }
}

final postRepo = PostsRepo();
