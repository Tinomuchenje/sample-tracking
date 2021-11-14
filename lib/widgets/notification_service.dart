import 'package:flutter/material.dart';

class NotificationService {
  static void success(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.greenAccent, content: Text(message)),
    );
  }

  static void warning(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orangeAccent,
      content: Text(message),
    ));
  }

  static void error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.redAccent, content: Text(message)),
    );
  }
}
