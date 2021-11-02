import 'package:flutter/material.dart';

import 'package:sample_tracking_system_flutter/consts/constants.dart';
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
                ElevatedButton(
                    onPressed: () {
                      _showMultiSelect(context);
                    },
                    child: const Text("Select Authorities")),
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

  void _showMultiSelect(BuildContext context) async {
    final items = <MultiSelectDialogItem<int>>[
      const MultiSelectDialogItem(1, 'Dog'),
      const MultiSelectDialogItem(2, 'Cat'),
      const MultiSelectDialogItem(3, 'Mouse'),
    ];

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return CustomMultiSelectDialog(
          items: items,
          initialSelectedValues: const {1, 3},
        );
      },
    );

    print(selectedValues);
  }
}
