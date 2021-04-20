import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  // final TextEditingController controller;
  final String label;
  final Color btnColor;
  final VoidCallback onPressed;
  final Color labelColor;
  final double borderRadius;

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
        child: Text(
          label,
          style: TextStyle(color: labelColor),
        ),
        style: TextButton.styleFrom(
            //  primary: labelColor,
            backgroundColor: btnColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius))),
      ),
    );
  }
}
