import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final Function(String?)? onSaved;
  final String? initialValue;
  CustomTextFormField(
      {this.hintText = "",
      required this.labelText,
      this.onSaved,
      this.initialValue});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: widget.hintText,
            labelText: widget.labelText,
          ),
          initialValue: widget.initialValue,
          onSaved: widget.onSaved,
          validator: (value) {
            if (value!.isEmpty) {
              return "Can not be empty";
            }
            return null;
          },
        ));
  }
}
