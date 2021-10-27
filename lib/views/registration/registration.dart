import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_elevated_button.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late final void Function()? press;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flexible(
          flex: 4,
          fit: FlexFit.loose,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  const Text(
                    "Registration",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Username", border: OutlineInputBorder()),
                    validator: (value) {},
                    onSaved: (value) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "First Name", border: OutlineInputBorder()),
                    validator: (value) {},
                    onSaved: (value) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Last name", border: OutlineInputBorder()),
                    validator: (value) {},
                    onSaved: (value) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Phone", border: OutlineInputBorder()),
                    validator: (value) {},
                    onSaved: (value) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Email", border: OutlineInputBorder()),
                    validator: (value) {},
                    onSaved: (value) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 50,
                    width: 340,
                    child: CustomElevatedButton(
                      displayText: "Register",
                      fillcolor: true,
                      press: (){},),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
