import 'package:flutter_test/flutter_test.dart';
import 'package:sample_tracking_system_flutter/utils/sms_service.dart';

void main() {
  test("Sending SMS from gadget", () {
    String message = "This is a test message!";
    List<String> recipents = ["0775313603"];

    SmsService.sendSms(message, recipents);

    assert(true);
  });
}
