import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/table_names.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/utils/sqlite_db.dart';

class SamplesProvider with ChangeNotifier {
  final dbHelper = DBHelper.instance;

  final Sample _sample = Sample();
  final List<Sample> _samples = [];

  Sample get sample => _sample;

  List<Sample> get samples {
    return [..._samples];
  }

  void addSample(Sample? sample) {
    if (sample == null) return;
    _samples.add(sample);

    addToLocalDatabase(sample);

    notifyListeners();
  }

  Future<int> addToLocalDatabase(Sample sample) async {
    var row = sample.toMap();
    row["internetStatus"] = 0; //Flag for no internet

    final id = await dbHelper.insert(tableSample, row);
    return id;
  }

  getAll() {}
  void removeAll() {
    _samples.clear();
  }
}
