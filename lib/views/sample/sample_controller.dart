import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/utils/dao/samples_dao.dart';
import 'package:http/http.dart' as http;

class SampleController {
  static Future<List<Sample>> getSamplesFromIds(List<String> sampleIds) async {
    List<Sample> samples = [];

    for (var sampleId in sampleIds) {
      await SampleDao()
          .getSample(sampleId)
          .then((sample) => {samples.add(sample)});
    }

    return samples;
  }

  Future<Sample> addOnlineSample(Sample sample) async {
    Sample savedSample = Sample();
    sample.synced = true;

    await http
        .post(Uri.parse(sampleUrl),
            headers: headers, body: json.encode(sample.toJson()))
        .then((response) {
      if (response.statusCode != 200) {
        sample.synced = false;
        savedSample = sample;
        return;
      }

      savedSample = Sample.fromJson(jsonDecode(response.body));
    }).catchError((error) {
      sample.synced = false;
      savedSample = sample;
    });

    return savedSample;
  }

  updateOnlineSample(Sample sample) {}
}
