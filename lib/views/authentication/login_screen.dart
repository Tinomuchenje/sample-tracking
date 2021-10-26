import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/models/user.dart';
import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';
import 'package:sample_tracking_system_flutter/utils/dao/laboratory_dao.dart';
import 'package:sample_tracking_system_flutter/views/authentication/state/user_provider.dart';
import 'package:sample_tracking_system_flutter/views/courier/dashboard.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home_page.dart';
import 'authentication_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  AppInformationDao appInformation = AppInformationDao();
  LaboratoryDao labsDao = LaboratoryDao();
  final AuthenticationUser _user = AuthenticationUser();

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    await AuthenticationController.login(_user).then((userDetails) async {
      if (userDetails.token.isEmpty) {
        return NotificationService.error(context, "Login failed.");
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user", userDetails.user.toString());
      prefs.setString("token", userDetails.token.toString());

      navigateToHome(userDetails.user!.role);
      NotificationService.success(context, "Login succesful.");
    });

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

  void navigateToHome(String role) {
    if (role == 'facility') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }

    if (role == 'courier') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const CourierDashboard()));
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
        child: Padding (
          padding: const EdgeInsets.all(23.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 4,
                fit: FlexFit.loose,
                child: Row(
                  children: [
                    // const SizedBox(height: 25),
                    // SizedBox(
                    //     height: 130,
                    //     child: Image.asset('assets/images/moh.png')),
                    // SizedBox(
                    //     height: 200,
                    //     child: Image.asset('assets/images/brt.jpg')),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              const Text(
                "SAMPLE TRACKING",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
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
