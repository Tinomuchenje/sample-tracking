import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';
import 'package:sample_tracking_system_flutter/providers/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/providers/user_provider.dart';
import 'package:sample_tracking_system_flutter/themes/style.dart';

import 'models/enums/user_type_enum.dart';
import 'providers/patient_provider.dart';
import 'views/authentication/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PatientProvider()),
        ChangeNotifierProvider(create: (context) => SamplesProvider()),
        ChangeNotifierProvider(create: (context) => ShipmentProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime? _lastQuitTime;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample Tracking App',
      theme: appTheme(),
      home: WillPopScope(
        onWillPop: () async {
          if (_lastQuitTime == null ||
              DateTime.now().difference(_lastQuitTime!).inSeconds > 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press again Back Button exit'),
              ),
            );
            _lastQuitTime = DateTime.now();
            return false;
          } else {
            Navigator.of(context).pop(true);
            return true;
          }
        },
        child: LoginPage(
          userType: UserType.client,
        ),
      ),
    );
  }
}
