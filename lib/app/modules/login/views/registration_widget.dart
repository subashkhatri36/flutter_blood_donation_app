import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/CustomButton.dart';
import '../../../Widgets/custome_text_field.dart';

final largeText = TextStyle(fontSize: 20);
final mediumText = TextStyle(fontSize: 16);
final smallText = TextStyle(fontSize: 12);

class RegistrationWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //       color: Colors.deepOrange,
        //       borderRadius:
        //           BorderRadius.only(bottomRight: Radius.circular(60))),
        //   height: height * .3,
        //   width: double.infinity,
        //   child: Stack(alignment: Alignment.center, children: [
        //     CircleAvatar(
        //       backgroundColor: Colors.white,
        //       radius: 35,
        //       child: CircleAvatar(
        //         radius: 34,
        //         backgroundColor: Theme.of(context).primaryColor,
        //         child: Container(
        //           height: 30,
        //           width: 30,
        //           decoration: BoxDecoration(
        //             //border: Border.all(color: Colors.white),
        //             borderRadius: BorderRadius.circular(40),
        //             image: DecorationImage(
        //               image: AssetImage(
        //                 'assets/images/request.png',
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //         right: 30,
        //         bottom: 30,
        //         child: Text(
        //           'Register',
        //           style: mediumText.copyWith(
        //               color: Colors.white, fontWeight: FontWeight.w600),
        //         ))
        //   ]),
        // ),
        // Expanded(
        //   child: Container(),
        // ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                CustomTextField(
                  round: true,
                  obscureText: false,
                  hintText: 'Fullname',
                  prefixIcon: Icons.email,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  round: true,
                  obscureText: false,
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  round: true,
                  obscureText: false,
                  hintText: 'Phone',
                  prefixIcon: Icons.email,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  round: true,
                  obscureText: true,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  round: true,
                  obscureText: true,
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: CustomButton(
            borderRadius: 15,
            btnColor: Colors.deepOrange,
            label: 'REGISTER',
            labelColor: Colors.white,
            onPressed: () {
              Get.offNamed('/home');
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already hava account "),
            InkWell(
              onTap: () {
                // authController.islogin.value = true;
              },
              child: Text(" Login",
                  style: smallText.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor)),
            )
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
