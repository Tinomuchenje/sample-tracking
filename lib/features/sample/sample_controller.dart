import 'dart:convert';

import 'package:sample_tracking_system_flutter/consts/api_urls.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/utils/dao/samples_dao.dart';
import 'package:http/http.dart' as http;
import 'package:sample_tracking_system_flutter/features/authentication/authentication_controller.dart';

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

  Future getOnlineSamples() async {
    var _headers = await AuthenticationController().buildHeader();

    await http.get(Uri.parse(sampleUrl), headers: _headers).then((response) {
      if (response.statusCode == 200) {
        var tokenMaps = jsonDecode(response.body);

        tokenMaps.forEach((value) async {
          Sample sample = Sample.fromJson(value);
          sample.synced = true;

          await SampleDao().insertOrUpdate(sample);
        });
      }
    });
  }

  Future addSamplesOnline() async {
    await SampleDao().getLocalSamples().then((samples) async {
      for (Sample sample in samples) {
        await createOrUpdate(sample);
      }
    });
  }

  Future<Sample> createOrUpdate(Sample sample) async {
    sample.synced = true;
    if (sample.id == null) {
      return await _createSample(sample);
    } else {
      return await _updateSample(sample);
    }
  }

  Future<Sample> _createSample(Sample sample) async {
    var _headers = await AuthenticationController().buildHeader();

    await http
        .post(Uri.parse(sampleUrl),
            headers: _headers, body: json.encode(sample))
        .then((response) {
      sample = _validateResponse(response, sample);
    }).catchError((error) {
      sample.synced = false;
    });
    return sample;
  }

  Sample _validateResponse(http.Response response, Sample sample) {
    if (response.statusCode == 201 || response.statusCode == 200) {
      sample = Sample.fromJson(jsonDecode(response.body));
    } else {
      sample.synced = false;
    }
    return sample;
  }

  Future _updateSample(Sample sample) async {
    var _headers = await AuthenticationController().buildHeader();

    await http
        .put(Uri.parse(sampleUrl + sample.id.toString()),
            headers: _headers, body: json.encode(sample))
        .then((response) {
      sample = _validateResponse(response, sample);
    }).catchError((error) {
      sample.synced = false;
    });
    return sample;
  }
}
