// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';

class CustomFormDropdown extends StatefulWidget {
  final String labelText;
  Object? value;
  List<DropdownMenuItem<Object>> items;
  Function(Object?)? onChanged;
  Function(Object?) onSaved;

  CustomFormDropdown(
      {Key? key,
      required this.items,
      required this.labelText,
      required this.value,
      required this.onChanged,
      required this.onSaved})
      : super(key: key);

  @override
  _CustomFormDropdownState createState() => _CustomFormDropdownState();
}

class _CustomFormDropdownState extends State<CustomFormDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: defaultPadding / 2, bottom: defaultPadding / 2),
      child: DropdownButtonFormField(
        menuMaxHeight: MediaQuery.of(context).size.height / 3,
        value: widget.value,
        items: widget.items,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        validator: (value) {
          if (value == null) {
            return "Can not be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
