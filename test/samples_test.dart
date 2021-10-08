import 'package:flutter_test/flutter_test.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';

void main() {
  group("Samples", () {
    test("Add new sample", () {
      // Arrange
      final sampleProvider = SamplesProvider();
      var sample =
          Sample(sampleType: "1", id: "1", clientPatientId: "1");

      // Act
      sampleProvider.addSample(sample);

      // Assert
      assert(sampleProvider.samples[0].sampleType == sample.sampleType);
    });

    test("Add sample Create records Length match samples", () {
      // Arrange
      final sampleProvider = SamplesProvider();
      Sample sampleOne =
          Sample(sampleType: "1", id: "1", clientPatientId: "1");

      Sample sampleTwo =
          Sample(sampleType: "1", id: "1", clientPatientId: "1");

      // Act
      sampleProvider.addSample(sampleOne);
      sampleProvider.addSample(sampleTwo);

      // Assert
      assert(sampleProvider.samples.length == 2);
    });

    test("Adding a valid sample When there is an exisiting one No Duplicates",
        () {
      // Arrange
      final sampleProvider = SamplesProvider();
      Sample sampleOne =
          Sample(sampleType: "1", id: "1", clientPatientId: "1");

      Sample sampleTwo =
          Sample(sampleType: "2", id: "2", clientPatientId: "2");

      // Act
      sampleProvider.addSample(sampleOne);
      sampleProvider.addSample(sampleTwo);

      // Assert
      assert(sampleProvider.samples[0].sampleType !=
          sampleProvider.samples[1].sampleType);
    });
  });
}
