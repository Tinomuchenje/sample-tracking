import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';
import 'package:sample_tracking_system_flutter/providers/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/utils/sqlite_db.dart';
import 'package:sample_tracking_system_flutter/views/pages/login_page.dart';
import 'package:provider/provider.dart';

import 'providers/patient_provider.dart';
import 'views/pages/user_options.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PatientProvider()),
        ChangeNotifierProvider(create: (context) => SamplesProvider()),
        ChangeNotifierProvider(create: (context) => ShipmentProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime? _lastQuitTime = null;
    final dbHelper = DBHelper.instance;
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
              const SnackBar(
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
        child: const UserOptions(),
      ),
    );
  }
}
