import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/routes.dart';
import 'package:sample_tracking_system_flutter/features/authentication/entry.dart';

import 'package:sample_tracking_system_flutter/features/sample/state/samples_provider.dart';
import 'package:sample_tracking_system_flutter/features/shipment/state/shipment_provider.dart';

import 'package:sample_tracking_system_flutter/themes/style.dart';

import 'consts/routing_constants.dart';
import 'features/authentication/data/access_levels.dart';
import 'features/authentication/data/user_provider.dart';
import 'features/patient/data_state/patient_provider.dart';
import 'features/shipment/shipments_screen.dart';

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
        // initialRoute: loginPage,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: const ShipmentsTab());
  }
}
