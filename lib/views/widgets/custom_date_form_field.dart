import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';

class DateFormField extends StatefulWidget {
  Function(Object?) onSaved;
  final String? initialValue;
  final String labelText;
  TextEditingController? dateController;

  DateFormField({
    Key? key,
    required this.onSaved,
    this.initialValue,
    this.dateController,
    required this.labelText,
  }) : super(key: key);

  @override
  _DateFormFieldState createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: defaultPadding / 2, bottom: defaultPadding / 2),
      child: TextFormField(
        initialValue: widget.initialValue,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.labelText,
        ),
        onTap: () => _selectDate(context),
        onSaved: widget.onSaved,
        controller: widget.dateController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Can not be empty";
          }
          return null;
        },
      ),
    );
  }

  Future _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1900),
        lastDate: date);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.dateController =
            TextEditingController(text: selectedDate.toString());
      });
    }
  }
}
