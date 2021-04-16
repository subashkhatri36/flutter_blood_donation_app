import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final String label;
  final Color hintcolor;
  final VoidCallback onPressed;
  final bool obscureText;
  final validator;
  final bool round;

  const CustomTextField(
      {Key key,
      this.controller,
      this.hintText,
      this.hintcolor,
      this.onPressed,
      this.obscureText = false,
      TextInputType textInputType,
      this.prefixIcon,
      this.validator,
      this.round,
      this.label})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            hintText: hintText,
            labelStyle: TextStyle(color: hintcolor),
            prefixIcon: Icon(prefixIcon),
            labelText: label,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    round ? Defaults.borderRadius : 0.0))));
  }
}
