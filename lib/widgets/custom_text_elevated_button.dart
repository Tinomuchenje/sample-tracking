import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomElevatedButton extends StatelessWidget {
  final String displayText;
  final bool fillcolor;
  final void Function()? press;
  static const circularRadius = 5.0;

  const CustomElevatedButton(
      {Key? key,
      required this.displayText,
      required this.fillcolor,
      required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var alternativeColor = Colors.grey;

    return TextButton(
      style: TextButton.styleFrom(
          primary: fillcolor ? Colors.white : alternativeColor,
          backgroundColor: fillcolor ? alternativeColor : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circularRadius),
              side: BorderSide(color: alternativeColor))),
      child: Text(
        displayText,
        style: TextStyle(
          color: fillcolor ? Colors.white : alternativeColor,
        ),
      ),
      onPressed: press,
    );
  }
}
