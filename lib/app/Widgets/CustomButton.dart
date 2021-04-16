import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';

class CustomButton extends StatelessWidget {
  // final TextEditingController controller;
  final String label;
  final Color btnColor;
  final VoidCallback onPressed;
  final Color labelColor;
  final int borderRadius;
  const CustomButton({
    Key key,
    this.label,
    this.btnColor,
    this.onPressed,
    this.labelColor,
    this.borderRadius,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(label),
        style: TextButton.styleFrom(
            primary: Theme.of(context).accentColor,
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Defaults.paddingbig))),
      ),
    );
  }
}
