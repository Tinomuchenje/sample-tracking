import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/utils/dao/samples_dao.dart';
import 'package:sample_tracking_system_flutter/utils/sqlite_db.dart';

class SamplesProvider with ChangeNotifier {
  final dbHelper = DBHelper.instance;

  final Sample _sample = Sample();
  final List<Sample> _samples = [];

  Sample get sample => _sample;

  List<Sample> get allSamples {
    if (_samples.isEmpty) allSamplesFromdatabase();
    return [..._samples];
  }

  List<Sample> get unshipedSamples {
    List<Sample> unshipedSamples = allSamples;
    unshipedSamples.removeWhere((sample) => sample.shipmentId!.isNotEmpty);
    return unshipedSamples;
  }

  void addSample(Sample? sample) async {
    if (sample == null) return;

    await SampleDao().insert(sample).then((key) {
      sample.id = key;
      _samples.add(sample);

      notifyListeners();
    }).catchError((onError) {});
  }

  updateSample(Sample sample) async {
    await SampleDao().update(sample);
    notifyListeners();
  }

  Future allSamplesFromdatabase() async {
    await SampleDao().getAll().then((value) {
      _samples.clear();
      _samples.addAll(value);
      notifyListeners();
    }).catchError((onError) {});
  }
}
