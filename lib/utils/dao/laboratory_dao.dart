import 'package:sample_tracking_system_flutter/models/laboritory.dart';
import 'package:sample_tracking_system_flutter/utils/sembast.dart';
import 'package:sembast/sembast.dart';

class LaboratoryDao {
  static const String tableName = "Labs";
  final _laboratoryTable = intMapStoreFactory.store(tableName);

  Future<Database> get _database async => AppDatabase.instance.database;

  Future insertLab(Laboratory laboritory) async {
    await _laboratoryTable.add(await _database, laboritory.toJson());
  }

  Future insertLabAsJson(Map<String, dynamic> value) async {
    await _laboratoryTable.add(await _database, value);
  }

  Future insertLabs(List<Map<String, dynamic>> value) async {
    await _laboratoryTable.addAll(await _database, value);
  }

  Future updateLab(Laboratory laboritory) async {
    final finder = Finder(filter: Filter.byKey(laboritory.id));
    await _laboratoryTable.update(await _database, laboritory.toJson(),
        finder: finder);
  }

  Future delete(Laboratory laboritory) async {
    final finder = Finder(filter: Filter.byKey(laboritory.id));
    await _laboratoryTable.delete(await _database, finder: finder);
  }

  Future<List<Laboratory>> getAllLabs() async {
    final recordSnapshot = await _laboratoryTable.find(await _database);

    return recordSnapshot.map((snapshot) {
      final labs = Laboratory.fromJson(snapshot.value);
      return labs;
    }).toList();
  }
}
