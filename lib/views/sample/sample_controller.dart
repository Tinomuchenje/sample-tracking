import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/utils/dao/samples_dao.dart';

class SampleController{
   static Future<List<Sample>> getSamplesFromIds(List<String> sampleIds) async {
    List<Sample> samples = [];

    for (var sampleId in sampleIds) {
      await SampleDao()
          .getSample(sampleId)
          .then((sample) => {samples.add(sample)});
    }

    return samples;
  }
}