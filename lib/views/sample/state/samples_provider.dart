import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/utils/dao/samples_dao.dart';
import 'package:sample_tracking_system_flutter/views/sample/sample_controller.dart';

import 'package:uuid/uuid.dart';

class SamplesProvider with ChangeNotifier {
  Uuid uuid = const Uuid();

  final Sample _sample = Sample();
  final List<Sample> _samples = [];

  Sample get sample => _sample;

  List<Sample> get allSamples {
    allSamplesFromdatabase();
    return [..._samples];
  }

  List<Sample> get unshipedSamples {
    List<Sample> unshipedSamples = allSamples;
    unshipedSamples.removeWhere((sample) => sample.shipmentId != "");
    return unshipedSamples;
  }

  void addSample(Sample sample) async {
    setValues(sample);
    try {
      SampleController().addOnlineSample(sample);
    } catch (error) {
      // print(error);
    }

    await saveOrUpdate(sample);
  }

  void setValues(Sample sample) {
    sample.appId = uuid.v1();
    sample.status = "Created";
    sample.synced = false;
    sample.clientSampleId = "SFDFASDS";
    sample.lastModifiedDate = _sample.createdDate = DateTime.now().toString();
    sample.dateSynced = _sample.dateCollected = DateTime.now().toString();
  }

  Future saveOrUpdate(Sample sample) async {
    await SampleDao().insertOrUpdate(sample).then((key) {
      _samples.clear();
      _samples.add(sample);
      notifyListeners();
    }).catchError((onError) {});
  }

  Future<void> allSamplesFromdatabase() async {
    await SampleDao().getAll().then((value) {
      _samples.clear();
      _samples.addAll(value);
      notifyListeners();
    });
    // .catchError((error) {
    //   print(error);
    // });
  }

  Future updateSample(Sample sample) async {
    await saveOrUpdate(sample);
    return notifyListeners();
  }
}
