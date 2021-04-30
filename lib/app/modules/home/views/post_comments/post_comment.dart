import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/constant/timeformatting.dart';
import 'package:flutter_blood_donation_app/app/core/model/comment_model.dart';
import 'package:flutter_blood_donation_app/app/core/model/request_model.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/comment_repo.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class PostComment extends StatelessWidget {
  final RequestModel request;
  final scrollController = ScrollController();
  final postController = Get.put(CommentController());
  final commentText = TextEditingController();
  PostComment({Key key, this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    postController.getComment(request.id);
    if (postController.commentData.length > 0)
      Timer(
        Duration(seconds: 0),
        () => scrollController.animateTo(
          scrollController.position.minScrollExtent - 100,
          duration: Duration(seconds: 1),
          curve: Curves.easeOut,
        ),
      );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBar(
            title: Text('Post Comment'),
          ),
          Obx(
            () => postController.commentData.length == 0
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.message_rounded),
                        Text(
                          'No comments yet',
                          style: largeText,
                        ),
                        Text(
                          'Be first to comment',
                          style: largeText,
                        )
                      ],
                    ),
                  )
                : Expanded(
                    flex: 9,
                    child: ListView.builder(
                        reverse: true,
                        controller: scrollController,
                        itemCount: postController.commentData.length,
                        itemBuilder: (_, int i) {
                          //   print(postController.commentData.length);
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: postController.commentData[i].userid ==
                                      userController.myinfo.value.userId
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                   padding: EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[400]
                                                          .withOpacity(.4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                child: Text(postController
                                                    .commentData[i].comment),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  print(postController.commentData[i].userid);
                                                },
                                                                                              child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      userController
                                                          .getUserByUserid(
                                                              postController
                                                                  .commentData[i]
                                                                  .userid)
                                                          .photoUrl??noimage),
                                                ),
                                              )
                                            ],
                                          ),
                                          //  Text('By ${userController.myinfo.value.username}',style: mediumText.copyWith(color:Colors.grey[800]),),
                                          // if (i ==
                                          //     postController
                                          //             .commentData.length -
                                          //         1)

                                          if (i == 0)
                                            Text(
                                              TimeFormatting
                                                  .displayTimeAgoFromTimestamp(
                                                postController
                                                    .commentData[i].timestamp
                                                    .toDate()
                                                    .toString(),
                                              ),
                                              style: smallText.copyWith(
                                                  color: Colors.grey),
                                            )
                                        ])
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[400]
                                                          .withOpacity(.4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Text(postController
                                                      .commentData[i].comment)),
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    userController
                                                        .getUserByUserid(
                                                            postController
                                                                .commentData[i]
                                                                .userid)
                                                        .photoUrl),
                                              )
                                            ],
                                          ),
                                          Text(
                                            'By ${userController.getUserByUserid(postController.commentData[i].userid).username}',
                                            style: mediumText.copyWith(
                                                color: Colors.grey[800]),
                                          ),
                                          Text(
                                            TimeFormatting
                                                .displayTimeAgoFromTimestamp(
                                              postController
                                                  .commentData[i].timestamp
                                                  .toDate()
                                                  .toString(),
                                            ),
                                            style: smallText.copyWith(
                                                color: Colors.grey),
                                          )
                                        ]));

                          //  ListTile(

                          //   leading: CircleAvatar(
                          //       backgroundImage:NetworkImage( userController.getUserByUserid(postController.commentData[i].userid).photoUrl)
                          //   ),
                          //   title: Text(postController.commentData[i].comment),
                          //   subtitle: Text('commented by: ${ userController.getUserByUserid(postController.commentData[i].userid).username}'),
                          //   trailing:CircleAvatar(
                          //       backgroundImage:NetworkImage( userController.getUserByUserid(postController.commentData[i].userid).photoUrl)
                          //   ),);
                        }),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 20),
            child: Container(
              height: 40,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.transparent)),
              child: Row(
                children: [
                  // Icon(
                  //   Icons.photo_album,
                  //   size: 30,
                  // ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      //color: Colors.grey,

                      child: TextField(
                        controller: commentText,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefix: null,
                          prefixIcon: null,
                          hintText: 'Comment here',
                          fillColor: Colors.grey,
                          hintStyle: smallText.copyWith(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // Icon(
                  //   Icons.emoji_emotions,
                  //   size: 30,
                  //   color: Colors.yellow[800],
                  // ),
                  SizedBox(
                    width: 14,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (commentText.text.trim() == '') {
                        Get.snackbar('Enter some value', 'no comment typed');
                      } else {
                        CommentModel comment = CommentModel(
                          postid: request.id,
                          userid: userController.myinfo.value.userId,
                          timestamp: Timestamp.now(),
                          comment: commentText.text,
                        );
                        commentRepo.sendComment(comment);
                        firebaseFirestore.collection('request').doc(request.id).update({'comment':request.comment+1});
                        commentText.clear();
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.blue,
                      size: 34,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
        ],
      ),
    );
  }
}

class CommentController extends GetxController {
  var commentData = List<CommentModel>.empty(growable: true).obs;
// ScrollController scrollController = new ScrollController();
  @override
  void onInit() {
    super.onInit();
    //  Timer(
    //   Duration(seconds: 2),
    //   () => scrollController .animateTo(scrollController.position.maxScrollExtent,duration: Duration(seconds:3),curve: Curves.fastOutSlowIn,),
    //);
    //  scrollController.jumpTo(scrollController. position.maxScrollExtent);
  }

  getComment(String postid) {
    commentData.bindStream(commentRepo.getComment(postid));
  }
}

class CommentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentController>(() => CommentController());
  }
}
