class Sample {
  String? sample_request_id;
  String? client_sample_id;
  String? patient_id;
  String? lab_id;
  String? client_id;
  String? sample_id;
  String? test_id;
  DateTime? date_collected;
  String? status;
  bool? synced;
  DateTime? synced_at;
  String? lab_reference_id;
  String? location;
  String? result;
  String? shipment_id;
  String? client_contact;
  DateTime? created_at;
  DateTime? modified_at;

  Sample(
      {this.sample_request_id,
      this.client_sample_id,
      this.patient_id,
      this.lab_id,
      this.client_id,
      this.sample_id,
      this.test_id,
      this.date_collected,
      this.status,
      this.synced,
      this.lab_reference_id,
      this.result,
      this.shipment_id,
      this.client_contact,
      this.created_at,
      this.modified_at,
      this.synced_at,
      this.location});

  Map<String, dynamic> toMap() {
    return {
      'sample_request_id': sample_request_id,
      'client_sample_id': client_sample_id,
      'patient_id': patient_id,
      'lab_id': lab_id,
      'client_id': client_id,
      'sample_id': sample_id,
      'test_id': test_id,
      'date_collected': date_collected.toString(),
      'status': status,
      'synced': synced,
      'synced_at': synced_at.toString(),
      'lab_reference_id': lab_reference_id,
      'location': location,
      'result': result,
      'shipment_id': shipment_id,
      'client_contact': client_contact,
      'created_at': created_at.toString(),
      'modified_at': modified_at.toString(),
    };
  }

  @override
  String toString() {
    return 'Sample{sample_request_id: $sample_request_id, client_sample_id: $client_sample_id, patient_id: $patient_id, lab_id: $lab_id, client_id: $client_id, sample_id: $sample_id, test_id: $test_id, date_collected: $date_collected, status: $status, synced: $synced, synced_at: $synced_at, lab_reference_id: $lab_reference_id, location: $location, result: $result, shipment_id: $shipment_id, client_contact: $client_contact, created_at: $created_at, modified_at: $modified_at}';
  }
}

// class SampleCrud extends DBHelper {
//   SampleCrud() {
//     getSamples();
//   }

//   Future<void> insertSample(Sample sample) async {
//     final database = await db;
//     await database.insert(tableSample, sample.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<List<Sample>> getSamples() async {
//     final database = await db;
//     // Query the table for all The Labs.
//     final List<Map<String, dynamic>> maps = await database.query(tableSample);

//     return List.generate(maps.length, (i) {
//       return Sample(
//         maps[i]['sample_request_id'],
//         maps[i]['client_sample_id'],
//         maps[i]['patient_id'],
//         maps[i]['lab_id'],
//         maps[i]['client_id'],
//         maps[i]['sample_id'],
//         maps[i]['test_id'],
//         DateTime.parse(maps[i]['date_collected']),
//         maps[i]['status'],
//         maps[i]['synced'] == 1 ? true : false,
//         maps[i]['lab_reference_id'],
//         maps[i]['result'],
//         maps[i]['shipment_id'],
//         maps[i]['client_contact'],
//         DateTime.parse(maps[i]['created_at']),
//         DateTime.parse(maps[i]['modified_at']),
//         DateTime.parse(maps[i]['synced_at']),
//         maps[i]['location'],
//       );
//     });
//   }
// }
