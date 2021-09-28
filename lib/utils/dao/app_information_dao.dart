import 'package:sembast/sembast.dart';

import '../sembast.dart';

class AppInformationDao {
  var store = StoreRef<String, String>.main();
  Future<Database> get _database async => AppDatabase.instance.database;

  Future saveLoginIndicator() async {
    await store.record('first').put(await _database, 'true');
  }

  Future<String?> getLoginIndicator() async {
    return await store.record('first').get(await _database);
  }

  clearLoginIndicator() async {
    await store.record('first').delete(await _database);
  }
}
