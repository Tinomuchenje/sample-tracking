import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/utils/sqlite_db.dart';
import 'package:sample_tracking_system_flutter/views/pages/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime? _lastQuitTime = null;
    DBHelper().initDb();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample Tracking App',
      home: WillPopScope(
        onWillPop: () async {
          print('Pressed');

          if (_lastQuitTime == null ||
              DateTime.now().difference(_lastQuitTime!).inSeconds > 1) {
            print('Press again Back Button exit');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press again Back Button exit'),
              ),
            );
            _lastQuitTime = DateTime.now();
            return false;
          } else {
            print('sign out');
            Navigator.of(context).pop(true);
            return true;
          }
        },
        child: LoginPage(),
      ),
    );
  }
}
