import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final String? Function(String?)? customValidator;
  String? initialValue;
  final bool? enabled;
  final String? controller;
  final TextInputType? keyboardType;

  CustomTextFormField(
      {Key? key,
      this.hintText = "",
      required this.labelText,
      this.onSaved,
      this.initialValue,
      this.enabled,
      this.controller,
      this.keyboardType,
      this.customValidator,
      this.onChanged})
      : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            top: defaultPadding / 2, bottom: defaultPadding / 2),
        child: TextFormField(
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: widget.hintText,
            labelText: widget.labelText,
          ),
          controller: setController(widget.controller),
          enabled: widget.enabled,
          initialValue: widget.initialValue,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          validator: widget.customValidator ??
              (value) {
                if (value!.isEmpty) {
                  return "Can not be empty";
                }
                return null;
              },
        ));
  }

  TextEditingController? setController(String? value) {
    if (value != null) widget.initialValue = null;

    return value == null ? null : TextEditingController(text: value);
  }
}
