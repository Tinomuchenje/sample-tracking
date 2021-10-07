import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/user_type_enum.dart';
import 'package:sample_tracking_system_flutter/providers/user_provider.dart';
import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';
import 'package:sample_tracking_system_flutter/utils/dao/laboratory_dao.dart';
import 'package:sample_tracking_system_flutter/views/pages/rider/dashboard.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_elevated_button.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  UserType userType;
  LoginPage({Key? key, required this.userType}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginData {
  String username = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> {
  _LoginData _data = new _LoginData();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  AppInformationDao appInformation = AppInformationDao();
  LaboratoryDao labsDao = LaboratoryDao();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);

      loadImportantInformation();
      appInformation.saveLoginIndicator();

      navigateToHome();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('logging in'),
        ),
      );
    }
  }

  void navigateToHome() {
    Provider.of<UserProvider>(context, listen: false).currentUser =
        widget.userType;

    if (widget.userType == UserType.client) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomePage()));
    }

    if (widget.userType == UserType.rider) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const Dashboard()));
    }
  }

  Future<void> loadLabs() async {
    var response = jsonDecode(await rootBundle.loadString('assets/labs.json'));
    saveLaboratories(response);
  }

  Future<void> saveLaboratories(response) async {
    await appInformation.getLoginIndicator().then((value) {
      value == null ? insert(response) : update(response);
    });
  }

  void insert(response) {
    for (var laboratory in response) {
      laboratory as Map<String, dynamic>;
      labsDao.insertLabAsJson(laboratory);
    }
  }

  void update(response) {
    for (var laboratory in response) {
      laboratory as Map<String, dynamic>;
      labsDao.insertLabAsJson(laboratory);
    }
  }

  loadImportantInformation() {
    loadLabs();
    //loadClientContact()
    //LoadOtherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "ESTS MOHCC APP",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _data.username = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                obscureText: _isObscure,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _data.password = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: CustomElevatedButton(
                        press: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          // _submit();
                        },
                        displayText: 'Request Access',
                        fillcolor: false,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: CustomElevatedButton(
                        press: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          _submit();
                        },
                        displayText: 'LogIn',
                        fillcolor: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
