import 'package:flutter_test/flutter_test.dart';
import 'package:sample_tracking_system_flutter/models/laboritory.dart';
import 'package:sample_tracking_system_flutter/utils/dao/laboratory_dao.dart';

void main() {
  group("Labs", () {
    test("Add Labs and Retrieve", () async {
      // Arrange
      LaboratoryDao laboratoryDao = LaboratoryDao();
      Laboratory laboratory = Laboratory(id: "1");
      List<Laboratory> laboratories;

      // Act
      await laboratoryDao.insertLab(laboratory);
      laboratories = await laboratoryDao.getAllLabs();

      // Assert
      assert(laboratories.isNotEmpty, true);
    });
  });
}
