import 'package:sample_tracking_system_flutter/models/user_details.dart';
import 'package:sembast/sembast.dart';

import '../sembast.dart';

class AppInformationDao {
  static const String tableName = "AppInfo";
  final _appInfo = stringMapStoreFactory.store(tableName);

  Future<Database> get _database async => AppDatabase.instance.database;

  Future saveUserDetails(User user) async {
    await _appInfo.record('user').put(await _database, user.toJson());
  }

  Future<User?> getUserDetails() async {
    var map = await _appInfo.record('user').get(await _database);
    return map != null ? User.fromJson(map) : null;
  }

  Future deleteLoggedInUser() async {
    await _appInfo
        .record('user')
        .delete(await _database)
        .catchError((error) {});
  }
}
