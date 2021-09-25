import 'package:sample_tracking_system_flutter/utils/sqlite_db.dart';
import 'package:sqflite/sqflite.dart';

const String tableLaboritory = "laboritory";



class Laboritory {
  final String laboratory_id;

  final String name;

  final String type;

  final String code;

  final String created_by;

  final DateTime created_date;

  final String last_modified_by;

  final DateTime last_modified_date;

  Laboritory(
      this.laboratory_id,
      this.name,
      this.type,
      this.code,
      this.created_by,
      this.created_date,
      this.last_modified_by,
      this.last_modified_date);

  Map<String, dynamic> toMap() {
    return {
      'laboratory_id': laboratory_id,
      'name': name,
      'type': type,
      'code': code,
      'created_by': created_by,
      'created_date': created_date.toString(),
      'last_modified_by': last_modified_by,
      'last_modified_date': last_modified_date.toString(),
    };
  }

  @override
  String toString() {
    return 'Laboritory{laboratory_id: $laboratory_id, name: $name, type: $type, code: $code, created_by: $created_by, created_date: $created_date, last_modified_by: $last_modified_by, last_modified_date: $last_modified_date}';
  }
}

// class LaboritoryCrud extends DBHelper {
//   Future<void> insertLab(Laboritory laboritory) async {
//     final database = await db;
//     await database.insert(tableLaboritory, laboritory.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<List<Laboritory>> getLabs() async {
//     final database = await db;
//     // Query the table for all The Labs.
//     final List<Map<String, dynamic>> maps =
//         await database.query(tableLaboritory);

//     return List.generate(maps.length, (i) {
//       return Laboritory(
//         maps[i]['laboratory_id'],
//         maps[i]['name'],
//         maps[i]['type'],
//         maps[i]['code'],
//         maps[i]['created_by'],
//         maps[i]['created_date'],
//         maps[i]['last_modified_by'],
//         maps[i]['last_modified_date'],
//       );
//     });
//   }
// }
