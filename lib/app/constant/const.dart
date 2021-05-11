import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth authResult = FirebaseAuth.instance;

final largeText = TextStyle(
  fontSize: 16,
);
final mediumText = TextStyle(fontSize: 16);
final smallText = TextStyle(fontSize: 14);

//colors
const grey = Colors.grey;

//noimage
String noimage =
    'https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png';
List<String> bloodgroup = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
