import 'package:flutter_test/flutter_test.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/views/patient/data_state/patient_provider.dart';

void main() {
  test("Add patient to server", () async{
    // Arrange
    Patient patient = Patient(
        firstName: 'test',
        lastName: 'user',
        gender: 'Male',
        client: '1',
        cohortNumber: '1',
        phoneNumber: '0777440550');

    // Act
    var result = await PatientProvider().addPatient(patient);

    // Assert
    assert(result != null);
  });
}
