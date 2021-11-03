import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/routes.dart';
import 'package:sample_tracking_system_flutter/views/authentication/entry.dart';

import 'package:sample_tracking_system_flutter/views/sample/state/samples_provider.dart';
import 'package:sample_tracking_system_flutter/views/shipment/state/shipment_provider.dart';

import 'package:sample_tracking_system_flutter/themes/style.dart';

import 'consts/routing_constants.dart';
import 'views/authentication/data/access_levels.dart';
import 'views/authentication/data/user_provider.dart';
import 'views/patient/data_state/patient_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PatientProvider()),
        ChangeNotifierProvider(create: (context) => SamplesProvider()),
        ChangeNotifierProvider(create: (context) => ShipmentProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AccessLevel())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sample Tracking App',
        theme: appTheme(),
        initialRoute: registerAccount,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: const Entry());
  }
}
