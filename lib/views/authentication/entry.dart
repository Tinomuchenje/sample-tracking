import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/views/authentication/data/models/user_details.dart';
import 'package:sample_tracking_system_flutter/utils/dao/app_information_dao.dart';
import 'package:sample_tracking_system_flutter/views/courier/dashboard.dart';
import 'package:sample_tracking_system_flutter/views/home/home_page.dart';

import 'login_screen.dart';

class Entry extends StatefulWidget {
  const Entry({Key? key}) : super(key: key);

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AppInformationDao().getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          var userDetails = snapshot.data;

          if (userDetails == null) {
            return const LoginPage();
          }
          userDetails as UserDetails;
          return userDetails.isCourierOnly(userDetails.authorities)
              ? const CourierDashboard()
              : HomePage();
        });
  }
}
