import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/consts/table_names.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/utils/db_models/sample_fields.dart';
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

  updateSample(Sample sample) async {
    var row = sample.toMap();
    row["internetStatus"] = 0; //Flag for no internet

    final id = await dbHelper.update(sample.sample_request_id,
        SampleTableFields.sample_request_id, tableSample, row);

    notifyListeners();
  }

  Future<int> addToLocalDatabase(Sample sample) async {
    var row = sample.toMap();
    row["internetStatus"] = 0; //Flag for no internet

    final id = await dbHelper.insert(tableSample, row);
    return id;
  }

  Future<void> allSamplesFromdatabase() async {
    final samplesMap = await dbHelper.queryAllRecords(tableSample);

    var result = List.generate(samplesMap.length, (index) {
      return Sample(
          sample_request_id: samplesMap[index]['sample_request_id'],
          client_sample_id: samplesMap[index]['client_sample_id'],
          patient_id: samplesMap[index]['patient_id'],
          lab_id: samplesMap[index]['lab_id'],
          client_id: samplesMap[index]['client_id'],
          sample_id: samplesMap[index]['sample_id'],
          test_id: samplesMap[index]['test_id'],
          date_collected: samplesMap[index]['date_collected'],
          status: samplesMap[index]['status'],
          synced: samplesMap[index]['synced'] == 1 ? true : false,
          date_synced: samplesMap[index]['synced_at'],
          lab_reference_id: samplesMap[index]['lab_reference_id'],
          location: samplesMap[index]['location'],
          result: samplesMap[index]['result'],
          shipment_id: samplesMap[index]['shipment_id'],
          client_contact: samplesMap[index]['client_contact'],
          created_at: samplesMap[index]['created_at'],
          modified_at: samplesMap[index]['modified_at']);
    });

    removeAll();
    _samples.addAll(result);
    notifyListeners();
  }

  void removeAll() {
    _samples.clear();
  }
}
