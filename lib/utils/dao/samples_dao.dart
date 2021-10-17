import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sembast/sembast.dart';

import '../sembast.dart';

class SampleDao {
  static const String tableName = "Sample";
  final _sampleTable = stringMapStoreFactory.store(tableName);

  Future<Database> get _database async => AppDatabase.instance.database;

  Future insertOrUpdate(Sample sample) async {
    String sampleId = sample.appId ?? "";
    await _sampleTable.record(sampleId).put(await _database, sample.toJson());
  }

  Future insertSamples(List<Map<String, dynamic>> value) async {
    await _sampleTable.addAll(await _database, value);
  }

  Future<Sample> getSample(String sampleId) async {
    var map = await _sampleTable.record(sampleId).get(await _database);
    if (map == null) return Sample();
    return Sample.fromJson(map);
  }

  Future delete(Sample sample) async {
    final finder = Finder(filter: Filter.byKey(sample.appId));
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
