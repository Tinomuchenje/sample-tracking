import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';

class CustomFormDropdown extends StatefulWidget {
  Widget hint;
  Object? value;
  List<DropdownMenuItem<Object>> items;
  Function(Object?) onChanged;
  Function(Object?) onSaved;

  CustomFormDropdown(
      {Key? key,
      required this.items,
      required this.hint,
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
        hint: widget.hint,
        items: widget.items,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
