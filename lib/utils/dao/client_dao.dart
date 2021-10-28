import 'dart:io';

import 'package:sample_tracking_system_flutter/models/client.dart';
import 'package:sample_tracking_system_flutter/utils/sembast.dart';
import 'package:sembast/sembast.dart';

class ClientDao {
  static const String tableName = "client";
  final _ClientTable = intMapStoreFactory.store(tableName);

  Future<Database> get _database async => AppDatabase.instance.database;

  Future insertClientAsJson(Map<String, dynamic> value) async {
    await _ClientTable.add(await _database, value);
  }

  Future insertAllClients(List<Map<String, dynamic>> values) async {
    await _ClientTable.addAll(await _database, values);
  }

  Future<List<Client>> getAllClient() async {
    final recordSnapshot = await _ClientTable.find(await _database);
    return recordSnapshot.map((snapshot) {
      final labs = Client.fromJson(snapshot.value);
      return labs;
    }).toList();
  }

  Future updateClient(Map<String, dynamic> client) async {
    final finder = Finder(filter: Filter.byKey(client['id']));
    await _ClientTable.update(await _database, client, finder: finder);
  }

  Future delete(Client client) async {
    final finder = Finder(filter: Filter.byKey(client.id));
    await _ClientTable.delete(await _database, finder: finder);
  }
}
