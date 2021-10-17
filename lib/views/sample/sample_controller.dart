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

  addOnlineSample(Sample sample) async {
    final response =
        await http.post(Uri.parse(addSampleUrl), body: sample.toJson());

    if (response.statusCode == 200) {
      return Sample.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  updateOnlineSample(Sample sample) {}
}
