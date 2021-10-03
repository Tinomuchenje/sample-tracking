import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';

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
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(300, 45))),
            onPressed: widget.onPressed,
            child: Text(widget.labelText)),
      ),
    );
  }
}
