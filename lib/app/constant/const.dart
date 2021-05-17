import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// AAAAxUCW8Jg:APA91bGmyvzBzu1kI2KF-s3tKNJMUwKBzMc8-GyJkEF9mrhl1bKidjJxYK4PoBm4n680d3UFLKSAs1VMwUcCjoa6zJrj8e3WTOdPcG6I8af5XUCEKI0Za9vTMMztPqty-rfeq53GJbNx
final Future<FirebaseApp> initialization = Firebase.initializeApp();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth authResult = FirebaseAuth.instance;
FirebaseMessaging messaging = FirebaseMessaging.instance;

final largeText = TextStyle(fontSize: 16, color: Colors.grey[700]);
final mediumText = TextStyle(fontSize: 16, color: Colors.grey[600]);
final smallText = TextStyle(fontSize: 14);

//colors
const grey = Colors.grey;

//noimage
String noimage =
    'https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png';
List<String> bloodgroup = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
