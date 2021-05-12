import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/model/like.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/core/model/review_model.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:flutter_blood_donation_app/app/core/model/user_rating_model.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/account_repository.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/like_repo.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/post_repo.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/rating_repositories.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/users_repo.dart';
import 'package:flutter_blood_donation_app/app/core/services/storage_service/get_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  LikeRepo _likeRepo = new LikeRepositiories();
  RatingRepo _ratingRepo = new RatingRepositiories();
  AccountRepo _accountRepo = AccountRepositories();
  var distance = 10.0.obs;
  RxBool presslike = false.obs;

  RxList<ReviewModel> reviewmodellist;
  RxBool loadRevew = false.obs;

  RxList<LikeModel> likeList;

  var connectionStatus = 0.obs;
  final Connectivity _connectivity = Connectivity();
  var selectedIndex = 0.obs;
  var loading = false.obs;
  var mapview = false.obs;
  var count = 0.obs;
  var mylatitude = 0.0.obs;
  var mylongitude = 0.0.obs;
  var myinfo = UserModel().obs;
  var userlist = List<UserModel>.empty(growable: true).obs;
  var requestData = List<RequestModel>.empty(growable: true).obs;
  var userlistshown = false.obs;
  RxBool requestload = false.obs;

  RxBool ratethisUser = false.obs;
  RxBool ratingchange = false.obs;
  UserRatingModel userRatingModel;
  RxList<UserRatingModel> userRatingModelList;

  TextEditingController reviewController = new TextEditingController();
  // var mapController = GoogleMapController();
  var ismap = true.obs;
  RxString docId = ''.obs;
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      Get.snackbar(e.code, e.message);
    } catch (e) {
      print(e.toString());
    }
    return _updateConnectionState(result);
  }

  loadingUserRating() async {
    var id = FirebaseAuth.instance.currentUser.uid;
    if (id != null) {
      List<UserRatingModel> datamodel = [];
      Either<String, List<UserRatingModel>> data =
          await _ratingRepo.loadingUserRating(id);

      data.fold((l) => Get.snackbar('Error', l.toString()), (r) {
        datamodel = r.toList();
        userRatingModelList = datamodel.obs;
      });
    }
  }

  bool checkUserrating(String userId) {
    bool status = false;
    if (userRatingModelList != null) {
      userRatingModelList.forEach((element) {
        if (userId == element.userId) {
          status = true;
          docId.value = element.docId;
          userRatingModel =
              new UserRatingModel(userId: element.userId, star: element.star);
        }
      });
    }
    return status;
  }

  int prevalue;
  setUserrating(int rate, UserModel model) async {
    ratingchange.toggle();

    var id = FirebaseAuth.instance.currentUser.uid;
    if (id != null) {
      if (checkUserrating(model.userId)) {
        if (prevalue == null) prevalue = userRatingModel.star;

        Either<String, String> updateData = await _ratingRepo.updateRating(
            id, docId.value, rate,
            usermodel: model, prevalue: prevalue);
        updateData.fold((l) => Get.snackbar('Error', l.toString()), (r) {
          UserRatingModel mdl = userRatingModel;
          mdl.star = rate;
          userRatingModel = mdl;
          prevalue = mdl.star;
          userRatingModelList.add(mdl);
          userRatingModelList.remove(userRatingModel);
          Get.snackbar('Successful', r.toString());
        });
      } else {
        Either<String, String> updateData =
            await _ratingRepo.insertrating(id, model.userId, rate);
        updateData.fold((l) => Get.snackbar('Error', l.toString()), (r) {
          userRatingModel = UserRatingModel(userId: docId.value, star: rate);
          userRatingModelList.add(userRatingModel);
          Get.snackbar('Successful', r.toString());
        });
      }
      ratingchange.toggle();
    }
  }

  void writeUserReview(UserModel usermodel) async {
    if (reviewController.text.trim().isNotEmpty) {
      ReviewModel mymodel = ReviewModel(
          id: myinfo.value.userId,
          name: myinfo.value.username,
          photo: myinfo.value.photoUrl,
          comment: reviewController.text);

      // print(reviewController.text);

      Either<String, String> writedata =
          await _accountRepo.insertUserReview(usermodel.userId, mymodel);
      writedata.fold((l) => Get.snackbar('Error', l.toString()), (r) {
        mymodel.id = r;
        if (reviewmodellist == null) reviewmodellist = [].obs;
        reviewmodellist.add(mymodel);
        reviewController.text = '';
        Get.back();
        Get.snackbar('Successful', 'Successfully added your review.');
      });
    } else {
      Get.snackbar('Error', 'Pleaase write some review and press post.');
    }
  }

  loadreview(UserModel usermodel) async {
    loadRevew.toggle();
    List<ReviewModel> rmodel = [];

    Either<String, List<ReviewModel>> reviewdata =
        await _accountRepo.getUserComment(usermodel.userId);
    reviewdata.fold((l) => Get.snackbar('Error', l.toString()), (r) {
      rmodel = r.toList();
      reviewmodellist = rmodel.obs;
    });
    loadRevew.toggle();
  }

  void _updateConnectionState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;

        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;
      default:
        Get.snackbar("Network Error", "Failed to connect ot network");
    }
  }

  loadAllLikes() async {
    var id = FirebaseAuth.instance.currentUser.uid;
    List<LikeModel> model = [];
    if (id != null) {
      Either<String, List<LikeModel>> datalike =
          await _likeRepo.getAllLikesNativeUser(id);
      datalike.fold((l) => print('Error on getting likes'), (r) {
        model = r.toList();
        likeList = model.obs;
      });
    }
  }

  bool notpress = false;

  insertLike({@required String postId, @required String likeuserId}) async {
    var id = FirebaseAuth.instance.currentUser.uid;
    presslike.toggle();

    if (id != null && !notpress) {
      notpress = true;
      if (checklikes(postId)) {
        String docId = getdocId(postId);
        //delete like
        Either<String, void> deletelike = await _likeRepo.deletelike(
            userId: id, docId: docId, postId: postId);
        deletelike.fold((l) => print(l.toString()), (r) {
          likeList.remove(LikeModel(postId: postId, docId: docId));
        });
      } else {
        //insert likes
        Either<String, String> insertlike =
            await _likeRepo.insertLike(userId: id, postId: postId);
        insertlike.fold((l) => print(l.toString()), (r) {
          LikeModel likemodel = new LikeModel(postId: postId, docId: r);
          if (likeList != null)
            likeList.add(likemodel);
          else {
            List<LikeModel> lmo = [];
            lmo.add(likemodel);
            likeList = lmo.obs;
          }
        });
      }
    }
    notpress = false;
    presslike.toggle();
  }

  String getdocId(String postId) {
    String like = '';
    if (likeList != null) {
      likeList.forEach((element) {
        if (postId == element.postId) like = element.docId;
      });
      return like;
    }
    return like;
  }

  bool checklikes(String postId) {
    bool like = false;
    if (likeList != null) {
      likeList.forEach((element) {
        if (postId == element.postId) like = true;
      });
      return like;
    }
    return like;
  }

  @override
  void onInit() {
    loadingUserRating();
    loadAllLikes();
    super.onInit();
    userlistshown = true.obs;

    getPosition();
    getUsers();

    getmyinfo();
    distance.value = (localStorage.read('distance')) ?? 10;
    streamRequest();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  getmyinfo() async {
    var mydata = localStorage.read('myinfo');
    if (mydata != null)
      myinfo.value = (UserModel.fromJson(mydata));
    else {
      myinfo.value = await userRepo.getmyinfo();
      localStorage.write('myinfo', myinfo.value.toJson());
    }
  }

  writeSettings() {
    localStorage.write('distance', distance.value);
  }

  getUsers() async {
    List<UserModel> users = await userRepo.getuser();
    // print(users.length);
    userlist = users.obs;
  }

  getUserByUserid(String userid) {
    List<UserModel> user = [];
    userlist.toList().forEach((element) {
      if (element.userId == userid) user.add(element);
    });
    return user[0];
  }

  getPosition() async {
    await Geolocator.getCurrentPosition().then((location) {
      mylatitude.value = location.latitude;
      mylongitude.value = location.longitude;
    });
  }

  streamRequest() async {
    loading.value = true;

    requestData.bindStream(postRepo.getRequest());
    loading.value = false;
  }

  //signout
  signout() async {
    await authResult.signOut();
    Get.offNamed('/login');
  }

  // getComment() {}
  // getlikes(String postid) {
  //   List<LikeModel> like = likeRepo.getlikes(postid);
  //   return like;
  // }

  // sendlike(String postid) {
  //   List<LikeModel> like = getlikes(postid);
  //   like.forEach((element) {
  //     if (element.userid == userController.myinfo.value.userId) {
  //       LikeModel like = LikeModel(
  //           postid: postid, userid: userController.myinfo.value.userId);
  //     } else {
  //       LikeModel like = LikeModel(
  //           postid: postid, userid: userController.myinfo.value.userId);
  //       likeRepo.sendlike(like);
  //     }
  //   });
  //}
}

final userController = Get.find<HomeController>();
