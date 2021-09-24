import 'package:flutter_test/flutter_test.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';

void main() {
  group("Samples", () {
    test("Add new sample", () {
      // Arrange
      final sampleProvider = SamplesProvider();
      var sample =
          Sample(sample_id: "1", sample_request_id: "1", patient_id: "1");

      // Act
      sampleProvider.add(sample);

      // Assert
      assert(sampleProvider.samples[0].sample_id == sample.sample_id);
    });

    test("Add sample Create records Length match samples", () {
      // Arrange
      final sampleProvider = SamplesProvider();
      Sample sampleOne =
          Sample(sample_id: "1", sample_request_id: "1", patient_id: "1");

      Sample sampleTwo =
          Sample(sample_id: "1", sample_request_id: "1", patient_id: "1");

      // Act
      sampleProvider.add(sampleOne);
      sampleProvider.add(sampleTwo);

      // Assert
      assert(sampleProvider.samples.length == 2);
    });

    test("Adding a valid sample When there is an exisiting one No Duplicates",
        () {
      // Arrange
      final sampleProvider = SamplesProvider();
      Sample sampleOne =
          Sample(sample_id: "1", sample_request_id: "1", patient_id: "1");

      Sample sampleTwo =
          Sample(sample_id: "2", sample_request_id: "2", patient_id: "2");

      // Act
      sampleProvider.add(sampleOne);
      sampleProvider.add(sampleTwo);

      // Assert
      assert(sampleProvider.samples[0].sample_id !=
          sampleProvider.samples[1].sample_id);
    });
  });
}
