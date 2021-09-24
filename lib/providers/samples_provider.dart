import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/table_names.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/utils/sqlite_db.dart';

class SamplesProvider with ChangeNotifier {
  final dbHelper = DBHelper.instance;
  
  Sample _sample = Sample();
  List<Sample> _samples = [];

  Sample get sample => _sample;

  List<Sample> get samples {
    return [..._samples];
  }

  Future<void> add(Sample? sample) async {
    if (sample == null) return;
    addToLocalDatabase(sample);

    notifyListeners();
  }

  Future<int> addToLocalDatabase(Sample sample) async {
    Map<String, dynamic> row = {
      tableSample: sample,
      dbHelper.internetStatus: 0
    };
    final id = await dbHelper.insert(tableSample, row);
    return id;
  }

  getAll() {}
}
