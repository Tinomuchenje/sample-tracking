import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final String role;
  const CustomCheckBox({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool defaulValue = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: defaulValue,
            onChanged: (value) {
              setState(() {
                if (value != null) defaulValue = value;
              });
            }),
        Text(widget.role),
      ],
    );
  }
}
