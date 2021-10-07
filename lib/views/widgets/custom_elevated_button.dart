import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomElevatedButton extends StatelessWidget {
  final String displayText;
  final bool fillcolor;
  final void Function()? press;
  static const circularRadius = 80.0;

  CustomElevatedButton(
      {required this.displayText,
      required this.fillcolor,
      required this.press});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          primary: fillcolor ? Colors.white : Theme.of(context).primaryColor,
          backgroundColor:
              fillcolor ? Theme.of(context).primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circularRadius),
              side: BorderSide(color: Theme.of(context).primaryColor))),
      child: Text(
        displayText,
        style: TextStyle(
          color: fillcolor ? Colors.white : Theme.of(context).primaryColor,
        ),
      ),
      onPressed: press,
    );
  }
}
