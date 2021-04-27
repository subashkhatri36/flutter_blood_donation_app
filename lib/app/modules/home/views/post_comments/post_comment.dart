import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';

class PostComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBar(
            title: Text('Post Comment'),
          ),
          Expanded(child: Container()),
          Column(
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
          Expanded(
            child: Container(),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 7),
            child: Container(
              height: 40,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.transparent)),
              child: Row(
                children: [
                  Icon(
                    Icons.photo_album,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      //color: Colors.grey,

                      child: TextField(
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
                  Icon(
                    Icons.emoji_emotions,
                    size: 30,
                    color: Colors.yellow[800],
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('send comment');
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
          // SizedBox(
          //   height: 3,
          // ),
        ],
      ),
    );
  }
}
