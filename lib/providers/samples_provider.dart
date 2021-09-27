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

    final id = await dbHelper.update(sample.sampleRequestId,
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
          sampleRequestId: samplesMap[index]['sample_request_id'],
          clientSampleId: samplesMap[index]['client_sample_id'],
          patientId: samplesMap[index]['patient_id'],
          labId: samplesMap[index]['lab_id'],
          // clientId: samplesMap[index]['client_id'],
          sampleId: samplesMap[index]['sample_id'],
          testId: samplesMap[index]['test_id'],
          dateCollected: samplesMap[index]['date_collected'],
          status: samplesMap[index]['status'],
          synced: samplesMap[index]['synced'] == 1 ? true : false,
          dateSynced: samplesMap[index]['synced_at'],
          //labReferenceId: samplesMap[index]['lab_reference_id'],
          location: samplesMap[index]['location'],
          //result: samplesMap[index]['result'],
          //shipmentId: samplesMap[index]['shipment_id'],
          //clientContact: samplesMap[index]['client_contact'],
          dateCreated: samplesMap[index]['created_at'],
          dateModified: samplesMap[index]['modified_at']);
    });

    removeAll();
    _samples.addAll(result);
    notifyListeners();
  }

  void removeAll() {
    _samples.clear();
  }
}
