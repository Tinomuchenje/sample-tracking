import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String labelText;
  final Function()? onPressed;

  CustomElevatedButton({required this.labelText, this.onPressed});

  @override
  _CustomElevatedButtonState createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed, child: Text(widget.labelText));
  }
}
