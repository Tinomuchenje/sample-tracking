import 'package:flutter/material.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/utils/dao/samples_dao.dart';
import 'package:sample_tracking_system_flutter/utils/date_service.dart';
import 'package:sample_tracking_system_flutter/features/sample/sample_controller.dart';

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
    await SampleController().createOrUpdate(sample).then((savedSample) {
      addToLocalDatabase(savedSample);
    });
  }

  void setValues(Sample sample) {
    if (sample.appId.isEmpty) sample.appId = uuid.v1();

    if (sample.status.isEmpty) {
      sample.status = "Created";
    }

    sample.lastModifiedDate =
        _sample.createdDate = DateService.convertToIsoString(DateTime.now());

    sample.dateSynced =
        _sample.dateCollected = DateService.convertToIsoString(DateTime.now());
  }

  Future addToLocalDatabase(Sample sample) async {
    await SampleDao().insertOrUpdate(sample).then((key) {
      _samples.clear();
      notifyListeners();
    }).catchError((onError) {});
  }

  Future<void> allSamplesFromdatabase() async {
    await SampleDao().getLocalSamples().then((value) {
      _samples.clear();
      _samples.addAll(value);
      notifyListeners();
    });
    // .catchError((error) {
    //   print(error);
    // });
  }
}
