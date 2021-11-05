import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/routing_constants.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/views/authentication/entry.dart';
import 'package:sample_tracking_system_flutter/views/authentication/login_screen.dart';

import 'views/authentication/register_account.dart';
import 'views/courier/dashboard.dart';
import 'views/home/home_page.dart';
import 'views/patient/add_patient.dart';
import 'views/sample/add_sample.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case entryPage:
        return navigateToPage(const Entry());

      case loginPage:
        return navigateToPage(const LoginPage());

      case registerAccountPage:
        return navigateToPage(const RegisterAccount());

      case facilityHomePage:
        return navigateToPage(HomePage());

      case courierHomePage:
        return navigateToPage(const CourierDashboard());

      case addUpdatePatient:
        return navigateToPage(AddorUpdatePatientDialog());

      case addUpdateSample:
        {
          final Patient? patient = settings.arguments as Patient;
          return navigateToPage(AddorUpdateSampleDialog(patient: patient));
        }

      default:
        return navigateToPage(const LoginPage());
    }
  }

  static MaterialPageRoute<dynamic> navigateToPage(dynamic page) =>
      MaterialPageRoute(builder: (_) => page);
}
