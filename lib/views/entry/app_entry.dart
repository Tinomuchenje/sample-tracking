import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/user_details.dart';
import 'package:sample_tracking_system_flutter/views/authentication/login_screen.dart';
import 'package:sample_tracking_system_flutter/views/courier/dashboard.dart';
import 'package:sample_tracking_system_flutter/views/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Entry extends StatefulWidget {
  const Entry({Key? key}) : super(key: key);

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  bool isUserLogged = false;
  String role = '';
  late User _user;

  Future<String> _checkLoginStatus() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    //Run the code after 200 milliseconds
    return Future.delayed(Duration(milliseconds: 200), () {
      _user = json.encode(shared.getString('user')) as User;
      role = _user.role;

      print(_user);

      String userToken = shared.getString('token') ?? "";
      if (userToken.length != 0) {
        if (this.mounted) {
          setState(() {
            isUserLogged = true;
          });
        }
      }
      return userToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return LoginPage();
          } else {
            print("Role here ");
            print(role);
            return role == 'facility' ? HomePage() : CourierDashboard();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
