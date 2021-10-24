import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/enums/user_type_enum.dart';
import 'package:sample_tracking_system_flutter/models/user.dart';
import 'package:sample_tracking_system_flutter/providers/user_provider.dart';
import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';
import 'package:sample_tracking_system_flutter/utils/dao/laboratory_dao.dart';
import 'package:sample_tracking_system_flutter/views/rider/dashboard.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/notification_service.dart';

import '../pages/home_page.dart';
import 'authentication_controller.dart';

class LoginPage extends StatefulWidget {
  UserType userType;
  LoginPage({Key? key, required this.userType}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  AppInformationDao appInformation = AppInformationDao();
  LaboratoryDao labsDao = LaboratoryDao();
  final User _user = User();

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    navigateToHome();
    // await AuthenticationController.getToken(_user).then((token) => {
    //       if (token.isNotEmpty)
    //         {
    //           Provider.of<UserProvider>(context, listen: false).logintoken = token,
    //           NotificationService.success(context, "Login succesful."),
    //           navigateToHome()
    //         }
    //       else
    //         {NotificationService.error(context, "Login failed.")}
    //     });
  }

  void navigateToHome() {
    Provider.of<UserProvider>(context, listen: false).currentUser =
        widget.userType;

    if (widget.userType == UserType.client) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(23.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 4,
                fit: FlexFit.loose,
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    SizedBox(
                        height: 130,
                        child: Image.asset('assets/images/moh.png')),
                    SizedBox(
                        height: 200,
                        child: Image.asset('assets/images/brt.jpg')),
                    const Text(
                      "SAMPLE TRACKING",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.loose,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
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
                            _user.username = value!;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: _isObscure,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
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
                            _user.password = value!;
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          width: 340,
                          child: CustomElevatedButton(
                            press: () {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
