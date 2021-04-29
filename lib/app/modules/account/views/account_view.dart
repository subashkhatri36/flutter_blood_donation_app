import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/Widgets/CustomButton.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/Viewcomment/bindings/viewcomment_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/request/bindings/request_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/request/views/request_view.dart';
import 'package:flutter_blood_donation_app/app/modules/updateaccount/bindings/updateaccount_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/updateaccount/views/updateaccount_view.dart';
import 'package:flutter_blood_donation_app/app/modules/viewcomment/views/viewcomment_view.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<AccountController>();

    return Scaffold(
        // appBar: AppBar(
        //   title: Text('AccountView'),
        // ),
        body: Obx(
      () => accountController.loadigUserData.isTrue
          ? Container(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 2,
                child: Column(
                  children: [
                    Obx(() => controller.backfromupdate.value
                        ? AccountHeaderWidget()
                        : AccountHeaderWidget()),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: Defaults.paddingnormal,
                            ),
                            Obx(() => controller.requestSendOn.value
                                ? RequestViewWidget()
                                : Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Defaults.paddingsmall),
                                    width: MediaQuery.of(context).size.width,
                                    height: Defaults.paddinglarge * 11,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Send Blood Request',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: Defaults.fontheading),
                                          textAlign: TextAlign.left,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Defaults.paddingbig),
                                          child: CustomButton(
                                            btnColor: Theme.of(context)
                                                .backgroundColor,
                                            label: 'Send',
                                            labelColor: Colors.white,
                                            onPressed: () {
                                              Get.to(() => RequestView(),
                                                  binding: RequestBinding());
                                            },
                                            borderRadius: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            RatingWidget(),
                            CommentWidget(),
                            CustomButton(
                              borderRadius: 15,
                              btnColor: Theme.of(context).backgroundColor,
                              label: 'Log Out',
                              labelColor: Colors.white,
                              onPressed: () {
                                accountController.signout();
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    ));
  }
}

class RequestViewWidget extends StatelessWidget {
  const RequestViewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Defaults.paddingsmall),
      width: MediaQuery.of(context).size.width,
      height: Defaults.paddinglarge * 11,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(Defaults.paddingsmall),
              padding: EdgeInsets.symmetric(horizontal: Defaults.paddingsmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      'Current Request',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Defaults.fontheading),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomButton(
                      btnColor: Colors.white,
                      label: 'VIEW',
                      labelColor: Theme.of(context).backgroundColor,
                      onPressed: () {},
                      borderRadius: 10,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: Defaults.paddingnormal),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Searching For',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Defaults.fontheading),
                      textAlign: TextAlign.left,
                    ),
                    CircleAvatar(
                      radius: Defaults.paddingbig * 2,
                      backgroundColor: Colors.blue,
                      child: CircleAvatar(
                        radius: Defaults.paddingbig * 2 - 4,
                        backgroundColor: Theme.of(context).backgroundColor,
                        child: Text('A+'),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Defaults.paddingbig),
                      child: Text(
                        'Near abcd Near abcdNear abcdNear abcdNear abcdNear abcdNear abcd',
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      width: Defaults.paddingnormal,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Defaults.paddingbig),
                      child: CustomButton(
                        btnColor: Theme.of(context).backgroundColor,
                        label: 'Close',
                        labelColor: Colors.white,
                        onPressed: () {},
                        borderRadius: 10,
                      ),
                    ),
                    SizedBox(
                      width: Defaults.paddingnormal,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<AccountController>();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Defaults.paddinglarge * 12,
      margin: EdgeInsets.all(Defaults.paddingnormal),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(Defaults.paddingsmall),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      'Comments',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Defaults.fontheading),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomButton(
                      btnColor: Colors.white,
                      label: 'VIEW ALL',
                      labelColor: Theme.of(context).backgroundColor,
                      onPressed: () {
                        Get.to(
                          () => ViewcommentView(),
                          binding: ViewcommentBinding(),
                        );
                      },
                      borderRadius: 10,
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Obx(() => accountController.loadComment.value
                ? CircularProgressIndicator()
                : (accountController.commentList?.length ?? 0) < 1
                    ? Container(
                        child: Center(child: Text('NO COMMENTS')),
                      )
                    : ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        reverse: true,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = accountController.commentList[index];
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Defaults.paddingnormal,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: data.photo.isEmpty
                                        ? AssetImage(
                                            'assets/images/logoapp.png')
                                        : NetworkImage(data.photo),
                                  ),
                                  SizedBox(
                                    width: Defaults.paddingnormal,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data.name),
                                      Text(
                                        data.comment,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: Defaults.fontnormal),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: accountController.commentList.length > 4
                            ? 4
                            : accountController.commentList.length))
          ],
        ),
      ),
    );
  }
}

class AccountHeaderWidget extends StatelessWidget {
  const AccountHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<AccountController>();

    return Container(
        width: MediaQuery.of(context).size.width,
        height: Defaults.paddinglarge * 10,
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: 68,
                      child: accountController.isImageUploading.isTrue
                          ? Center(child: CircularProgressIndicator())
                          : Text(''),
                      backgroundImage: accountController.isImageNetwork.value
                          ? NetworkImage(accountController.userImage.value)
                          : accountController.image != null
                              ? FileImage(
                                  accountController.image,
                                )
                              : AssetImage(
                                  'assets/images/blooddonation.png',
                                )),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      backgroundColor: Theme.of(context).backgroundColor,
                      radius: 22,
                      child: Text(accountController.model.bloodgroup)),
                ),
                Positioned(
                  bottom: 4,
                  right: 2,
                  child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).backgroundColor,
                        radius: 16,
                        child: IconButton(
                          icon: Icon(
                            Icons.camera,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            accountController.getImage(true);
                          },
                        ),
                      )),
                ),
              ]),
              SizedBox(height: Defaults.paddingsmall),
              Text(
                accountController.model.username,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                accountController.model.phoneNo,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                accountController.model.email,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    Get.to(() => UpdateaccountView(),
                        binding: UpdateaccountBinding(),
                        arguments: accountController.model);
                  })
            ],
          ),
        ));
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<AccountController>();
    return Card(
      margin: EdgeInsets.all(Defaults.paddingnormal),
      child: Obx(() => accountController.loadigUserData.isTrue
          ? Container(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: EdgeInsets.all(Defaults.paddingbig),
              padding: EdgeInsets.all(Defaults.paddingbig),
              child: Column(
                children: [
                  Text('Your Rating Overview',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Defaults.fontheading)),
                  SizedBox(
                    height: Defaults.paddingsmall,
                  ),
                  Obx(() => Text(
                        accountController.average.value.toStringAsFixed(2),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Defaults.fontheading * 2),
                      )),
                  Text(
                    'Average Rating',
                  ),
                  SizedBox(
                    height: Defaults.paddingsmall,
                  ),
                  for (int i = 5; i >= 1; i--)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child:
                                Text(i.toString(), textAlign: TextAlign.right)),
                        Expanded(flex: 2, child: Icon(Icons.star)),
                        Expanded(
                          flex: 7,
                          child: LinearPercentIndicator(
                            lineHeight: 5.0,
                            percent: accountController.showpercentage(i),
                            backgroundColor: Colors.grey,
                            progressColor: progressColor(i, context),
                          ),
                        )
                      ],
                    ),
                  Divider(),
                  Text('Total : ${accountController.total.value}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Defaults.fontheading))
                ],
              ),
            )),
    );
  }
}

Color progressColor(int i, BuildContext context) {
  switch (i) {
    case 1:
      return Theme.of(context).backgroundColor;
      break;
    case 2:
      return Colors.deepOrange;
      break;
    case 3:
      return Colors.yellow;
      break;
    case 4:
      return Colors.green[300];
      break;
    default:
      return Colors.orange;
      break;
  }
}
