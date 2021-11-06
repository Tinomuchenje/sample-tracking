import 'package:flutter_test/flutter_test.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/features/sample/state/samples_provider.dart';

void main() {
  group("Samples", () {
    test("Add new sample", () {
      // Arrange
      final sampleProvider = SamplesProvider();
      var sample = Sample(sampleType: "1", appId: "1", clientPatientId: "1");

      // Act
      sampleProvider.addSample(sample);

      // Assert
      assert(sampleProvider.allSamples[0].sampleType == sample.sampleType);
    });

    test("Add sample Create records Length match samples", () {
      // Arrange
      final sampleProvider = SamplesProvider();
      Sample sampleOne = Sample(sampleType: "1", appId: "1", clientPatientId: "1");

      Sample sampleTwo = Sample(sampleType: "1", appId: "1", clientPatientId: "1");

      // Act
      sampleProvider.addSample(sampleOne);
      sampleProvider.addSample(sampleTwo);

      // Assert
      assert(sampleProvider.allSamples.length == 2);
    });

    test("Adding a valid sample When there is an exisiting one No Duplicates",
        () {
      // Arrange
      final sampleProvider = SamplesProvider();
      Sample sampleOne = Sample(sampleType: "1", appId: "1", clientPatientId: "1");

      Sample sampleTwo = Sample(sampleType: "2", appId: "2", clientPatientId: "2");

      // Act
      sampleProvider.addSample(sampleOne);
      sampleProvider.addSample(sampleTwo);

      // Assert
      assert(sampleProvider.allSamples[0].sampleType !=
          sampleProvider.allSamples[1].sampleType);
    });

    test("Get Unshiped Samples", () {
      // Arrange
      final sampleProvider = SamplesProvider();
      Sample sampleOne = Sample();

      Sample sampleTwo = Sample(shipmentId: "1");
      // Act
      
      sampleProvider.addSample(sampleOne);
      sampleProvider.addSample(sampleTwo);
      // Assert

      assert(sampleProvider.unshipedSamples.length == 1);
    });
  });
}
