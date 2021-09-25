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

    final id = await dbHelper.update(sample.sample_id,
        SampleTableFields.sample_request_id, tableSample, row);

    notifyListeners();
  }

  Future<int> addToLocalDatabase(Sample sample) async {
    var row = sample.toMap();
    row["internetStatus"] = 0; //Flag for no internet

    final id = await dbHelper.insert(tableSample, row);
    return id;
  }

  Future<List<Sample>> get allSamplesFromdatabase async {
    final samplesMap = await dbHelper.queryAllRecords(tableSample);
    var result = List.generate(
        samplesMap.length, (index) => buildSample(samplesMap, index));
    notifyListeners();
    return result;
  }

  Sample buildSample(List<Map<String, dynamic>> samplesMap, int index) {
    return Sample(
      sample_request_id: samplesMap[index][SampleTableFields.sample_request_id],
      client_sample_id: samplesMap[index][SampleTableFields.client_sample_id],
      patient_id: samplesMap[index][SampleTableFields.patient_id],
      lab_id: samplesMap[index][SampleTableFields.lab_id],
      client_id: samplesMap[index][SampleTableFields.client_id],
      sample_id: samplesMap[index][SampleTableFields.sample_id],
      test_id: samplesMap[index][SampleTableFields.test_id],
      date_collected: samplesMap[index][SampleTableFields.date_collected],
      status: samplesMap[index][SampleTableFields.status],
      synced: samplesMap[index][SampleTableFields.synced],
      synced_at: samplesMap[index][SampleTableFields.synced_at],
      lab_reference_id: samplesMap[index][SampleTableFields.lab_reference_id],
      location: samplesMap[index][SampleTableFields.location],
      result: samplesMap[index][SampleTableFields.result],
      shipment_id: samplesMap[index][SampleTableFields.shipment_id],
      client_contact: samplesMap[index][SampleTableFields.client_contact],
      created_at: samplesMap[index][SampleTableFields.created_at],
      modified_at: samplesMap[index][SampleTableFields.modified_at],
    );
  }

  void removeAll() {
    _samples.clear();
  }
}
