import 'package:flutter_sms/flutter_sms.dart';

class SmsService {
  static void sendSms(String message, List<String> recipents) async {
    sendSMS(message: message, recipients: recipents)
        .then((value) => print(value))
        .catchError((error) => print(error));
  }
}
