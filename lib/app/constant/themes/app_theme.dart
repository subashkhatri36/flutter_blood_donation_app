import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Themes {
  static Color lightBackgroundColor = HexColor('#cd0001');
  static Color lightPrimaryColor = const Color(0xfff2f2f2);
  static Color lightAccentColor = Colors.white; //Colors.blueGrey.shade200;
  static Color lightBtnColor = Colors.deepOrange;

  static final light = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: lightBackgroundColor,
    accentColor: lightAccentColor,
    backgroundColor: lightBackgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
