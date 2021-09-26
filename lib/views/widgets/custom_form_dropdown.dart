import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';

class CustomFormDropdown extends StatefulWidget {
  Widget hint;
  Object? value;
  List<DropdownMenuItem<Object>> items;
//Function(Object?) onSaved;

  CustomFormDropdown(
      {Key? key, required this.items, required this.hint, required this.value})
      : super(key: key);

  @override
  _CustomFormDropdownState createState() => _CustomFormDropdownState();
}

class _CustomFormDropdownState extends State<CustomFormDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: DropdownButtonFormField(
        value: widget.value,
        hint: widget.hint,
        items: widget.items,
        //onSaved: widget.onSaved,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
