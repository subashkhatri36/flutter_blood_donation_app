import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/Widgets/CustomButton.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/core/model/donation_model.dart';
import 'package:flutter_blood_donation_app/app/modules/ViewAllReviews/bindings/view_all_reviews_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/ViewAllReviews/views/view_all_reviews_view.dart';
import 'package:flutter_blood_donation_app/app/modules/donation/bindings/donation_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/donation/controllers/donation_controller.dart';
import 'package:flutter_blood_donation_app/app/modules/donation/views/donation_view.dart';
import 'package:flutter_blood_donation_app/app/modules/request/bindings/request_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/request/views/request_view.dart';
import 'package:flutter_blood_donation_app/app/modules/updateaccount/bindings/updateaccount_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/updateaccount/views/updateaccount_view.dart';
import 'package:flutter_blood_donation_app/app/modules/viewallrequest/bindings/viewallrequest_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/viewallrequest/views/viewallrequest_view.dart';
import 'package:flutter_blood_donation_app/app/utlis/rating.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controllers/account_controller.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView>
    with SingleTickerProviderStateMixin {
  final donationController = Get.put(DonationController());
  final controller = Get.find<AccountController>();
  TabController _controller;
  List<Widget> list = [
    Tab(
      text: 'Requests',
    ),
    Tab(
      text: 'Donations',
    ),
    Tab(
      text: 'Reviews',
    ),
  ];
  @override
  void initState() {
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {});
      //print("Selected Index: " + _controller.index.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<AccountController>();
    accountController.getCurrentRequest();
    print(accountController.requestSendOn.value);
    // print(accountController.model.bloodgroup);

    return Scaffold(
        body: Obx(
      () => accountController.loadigUserData.isTrue
          ? Container(
              child: Center(
              child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor),
            ))
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Obx(() => controller.backfromupdate.value
                        ? AccountHeaderWidget()
                        : AccountHeaderWidget()),
                    Expanded(
                        child: Column(
                      children: [
                        TabBar(
                          indicatorColor: Colors.black,
                          labelColor: Theme.of(context).primaryColor,
                          onTap: (index) {
                            // Should not used it as it only called when tab options are clicked,
                            // not when user swapped
                          },
                          controller: _controller,
                          tabs: list,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _controller,
                            children: [
                              SingleChildScrollView(
                                child: Obx(() => controller.requestSendOn.value
                                    ? RequestViewWidget()
                                    : Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Defaults.paddingsmall),
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                                  fontSize:
                                                      Defaults.fontheading),
                                              textAlign: TextAlign.left,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Defaults.paddingbig),
                                              child: CustomButton(
                                                btnColor: Theme.of(context)
                                                    .backgroundColor,
                                                label: 'Request Now',
                                                labelColor: Colors.white,
                                                onPressed: () {
                                                  Get.to(() => RequestView(),
                                                      binding:
                                                          RequestBinding());
                                                },
                                                borderRadius: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                              ),
                              //2
                              Donation(accountController.model.bloodgroup),
                              //3
                              SingleChildScrollView(
                                child: Container(
                                  height: Defaults.paddinglarge * 38,
                                  child: Column(
                                    children: [
                                      RatingWidget(),
                                      CommentWidget(),
                                      SizedBox(height: Defaults.paddingbig)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
    ));
  }
}

class Donation extends StatelessWidget {
  Donation(this.id);
  final id;

  @override
  Widget build(BuildContext context) {
    final donationController = Get.find<DonationController>();
    return Container(
      margin: EdgeInsets.all(Defaults.paddingmiddle),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            padding: EdgeInsets.all(Defaults.paddingmiddle),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Donation',
                    style: TextStyle(
                        fontSize: Defaults.fontheading, color: Colors.white)),
                InkWell(
                  onTap: () {
                    Get.to(DonationView(),
                        binding: DonationBinding(), arguments: id);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'Add Donation',
                      style: TextStyle(
                          fontSize: Defaults.fontnormal, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => donationController.isloading.isFalse
                ? donationController.donationList.length > 0
                    ? AllDonationview(
                        donationController: donationController,
                        del: true,
                      )
                    : Text('No Donation Yet.')
                : Container(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  )),
          ),
        ],
      ),
    );
  }
}

class AllDonationview extends StatelessWidget {
  const AllDonationview({
    Key key,
    @required this.donationController,
    this.del = false,
  }) : super(key: key);
  final bool del;

  final DonationController donationController;

  @override
  Widget build(BuildContext context) {
    var value;
    if (del == false)
      value = donationController.donationListSpecial;
    else
      value = donationController.donationList;

    if (value != null)
      return ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            DonationModel model = value[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                child: Text("${model.bloodtype}"),
              ),
              title: Text(
                'Donated to ' + model.person + '.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Defaults.fontsubheading),
              ),
              subtitle: Text('${model.details} --On ${model.date}'),
              trailing: del
                  ? IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        return showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Dialog'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        'Are you Sure to delete your donation info.'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Delete'),
                                  onPressed: () {
                                    donationController.deleteDonation(model);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      })
                  : Icon(null),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: del == false
              ? (donationController.donationListSpecial?.length ?? 0) > 2
                  ? 2
                  : donationController.donationList?.length ?? 0
              : donationController.donationList?.length ?? 0);
    else
      return Text(donationController.nodata.value);
  }
}

class RequestViewWidget extends StatelessWidget {
  const RequestViewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userRequest = Get.find<AccountController>();
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
                          color: Colors.grey,
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
                        Get.to(() => ViewallrequestView(),
                            binding: ViewallrequestBinding());
                      },
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
                        child: Text(userRequest.myrequestList[0].bloodgroup),
                        // child: Text(userRequest.currentRequest != null
                        //     ? userRequest.currentRequest.bloodgroup
                        //     : 'Na'),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Defaults.paddingbig),
                      child: Text(
                        userRequest.myrequestList != null
                            ? userRequest.myrequestList[0].address
                            : 'No address',
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
                        onPressed: () {
                          return showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Dialog'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'Are you Sure to delete your Request.'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () {
                                      userRequest.deleteRequest();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
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
    accountController.loadingComment();
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
                      'Reviews',
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
                          () => ViewAllReviewsView(),
                          binding: ViewAllReviewsBinding(),
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
                : (accountController.reviewList?.length ?? 0) < 1
                    ? Container(
                        child: Center(child: Text('No Reviews')),
                      )
                    : Obx(() => ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        reverse: true,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = accountController.reviewList[index];
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
                        itemCount: accountController.reviewList.length > 4
                            ? 4
                            : accountController.reviewList.length)))
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

    return Obx(() => Container(
        width: MediaQuery.of(context).size.width,
        height: Defaults.paddinglarge * 9,
        decoration: BoxDecoration(
            // color: Colors.grey,
            image: DecorationImage(
                image: accountController.isImageNetwork.value
                    ? NetworkImage(accountController.userImage.value)
                    : accountController.image != null
                        ? FileImage(
                            accountController.image,
                          )
                        : AssetImage(
                            'assets/images/bannerImage.jpeg',
                          ),
                fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Stack(
            children: [
              Center(
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
                            backgroundImage:
                                accountController.isImageNetwork.value
                                    ? NetworkImage(
                                        accountController.userImage.value)
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
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
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
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      accountController.model.phoneNo,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      accountController.model.email,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      Get.to(() => UpdateaccountView(),
                          binding: UpdateaccountBinding(),
                          arguments: accountController.model);
                    }),
              ),
            ],
          ),
        )));
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
