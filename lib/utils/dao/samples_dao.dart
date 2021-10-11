import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sembast/sembast.dart';

import '../sembast.dart';

class SampleDao {
  static const String tableName = "Sample";
  final _sampleTable = intMapStoreFactory.store(tableName);

  Future<Database> get _database async => AppDatabase.instance.database;

  Future insert(Sample sample) async {
    await _sampleTable.add(await _database, sample.toJson());
  }

  Future insertAsJson(Map<String, dynamic> value) async {
    await _sampleTable.add(await _database, value);
  }

  Future insertSamples(List<Map<String, dynamic>> value) async {
    await _sampleTable.addAll(await _database, value);
  }

  Future update(Sample sample) async {
    final finder = Finder(filter: Filter.byKey(sample.id));
    await _sampleTable.update(await _database, sample.toJson(), finder: finder);
  }

  Future delete(Sample sample) async {
    final finder = Finder(filter: Filter.byKey(sample.id));
    await _sampleTable.delete(await _database, finder: finder);
  }

  Future<List<Sample>> getAll() async {
    final recordSnapshot = await _sampleTable.find(await _database);

    return recordSnapshot.map((snapshot) {
      final samples = Sample.fromJson(snapshot.value);
      return samples;
    }).toList();
  }
}
