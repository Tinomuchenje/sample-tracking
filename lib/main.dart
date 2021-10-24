import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sample_tracking_system_flutter/views/sample/state/samples_provider.dart';
import 'package:sample_tracking_system_flutter/providers/shipment_provider.dart';
import 'package:sample_tracking_system_flutter/providers/user_provider.dart';
import 'package:sample_tracking_system_flutter/themes/style.dart';

import 'models/enums/user_type_enum.dart';
import 'views/patient/data_state/patient_provider.dart';
import 'views/authentication/login_screen.dart';
import 'views/patient/patients_tab.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample Tracking App',
      theme: appTheme(),
      home: const PatientsTab(),
    );
  }
}
