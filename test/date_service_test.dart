import 'package:flutter_test/flutter_test.dart';
import 'package:sample_tracking_system_flutter/utils/date_service.dart';

void main() {
  test("Convert to ISO string", () {
    // Arrange
    var date = DateTime(2014, 02, 15, 08, 57, 47, 812);

    // Act
    var result = DateService.convertToIsoString(date);

    // Assert
    assert(result == "2014-02-15T08:57:47.812");
  });

  test("Convert date", () {
    // Arrange
    var date = DateTime(2014, 02, 15, 08, 57, 47, 812);

    // Act
    var result = DateService.removeTime(date);

    // Assert
    assert(result == "15-2-2014");
  });
}
