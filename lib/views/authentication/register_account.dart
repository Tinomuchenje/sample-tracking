import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/views/authentication/user_types_constants.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_form_dropdown.dart';

import 'package:sample_tracking_system_flutter/widgets/custom_multiselect_dropdown.dart';

import 'package:sample_tracking_system_flutter/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_form_field.dart';

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({Key? key}) : super(key: key);

  @override
  _RegisterAccountState createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  final _formKey = GlobalKey<FormState>();
  List<String> authorities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(children: [
                CustomTextFormField(labelText: 'First Name'),
                CustomTextFormField(labelText: 'Last Name'),
                CustomTextFormField(
                  labelText: 'Email address',
                  hintText: 'yourname@brti.co.zw',
                ),
                _selectAuthorities(context),
                _selectAccessLevel(),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: CustomElevatedButton(
                    press: () {
                      if (!_formKey.currentState!.validate()) return;
                    },
                    displayText: 'Create Account',
                    fillcolor: true,
                  ),
                ),
              ])),
        ),
      ),
    );
  }

  CustomFormDropdown _selectAccessLevel() {
    String selectedLevel = 'Nothing Selected';
    List<String> levels = [
      'Nothing Selected',
      'Province',
      'District',
      'Client'
    ];

    var displayOptions = levels.map((level) {
      return DropdownMenuItem<String>(value: level, child: Text(level));
    }).toList();

    return CustomFormDropdown(
      items: displayOptions,
      onChanged: (value) {},
      onSaved: (value) {},
      value: selectedLevel,
      hint: const Text('Access level'),
    );
  }

  Padding _selectAuthorities(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: defaultPadding / 2, bottom: defaultPadding / 2),
      child: TextFormField(
        controller: TextEditingController(text: authorities.take(3).join(', ')),
        keyboardType: TextInputType.none,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.arrow_drop_down_sharp),
          border: OutlineInputBorder(),
          labelText: 'Select Authorities',
        ),
        onTap: () {
          _showMultiSelect(context);
        },
      ),
    );
  }

  List<MultiSelectDialogItem<String>> _buildMulitiselect(
      Map<String, String> values) {
    List<MultiSelectDialogItem<String>> displayOptions = [];

    for (String option in values.keys) {
      displayOptions.add(MultiSelectDialogItem(option, values[option] ?? ''));
    }

    return displayOptions;
  }

  void _showMultiSelect(BuildContext context) async {
    final valueToPopulate = {
      healthWorker: 'Health worker',
      courier: 'Courier',
      hub: 'Hub',
      admin: 'Admin'
    };

    List<MultiSelectDialogItem<String>> items = [];

    for (String option in valueToPopulate.keys) {
      items.add(MultiSelectDialogItem(option, valueToPopulate[option] ?? ''));
    }

    final selectedValues = await showDialog<Set<String>>(
      context: context,
      builder: (BuildContext context) {
        return CustomMultiSelectDialog(
          items: items,
          title: 'Add authorities',
        );
      },
    );

    if (selectedValues != null) {
      setState(() {
        authorities = selectedValues.toList();
      });
    }
  }
}
