import 'package:sample_tracking_system_flutter/views/authentication/data/models/user_details.dart';
import 'package:sembast/sembast.dart';

import '../sembast.dart';

class AppInformationDao {
  final _appInfo = StoreRef.main();

  Future<Database> get _database async => AppDatabase.instance.database;

  Future saveUserDetails(UserDetails userDetails) async {
    await _appInfo.record('user').put(await _database, userDetails.toJson());
  }

  Future<UserDetails?> getUserDetails() async {
    var map = await _appInfo.record('user').get(await _database);
    return map != null ? UserDetails.fromJson(map) : null;
  }

  Future<String> saveToken(String idToken) async {
    return await _appInfo.record('user-token').put(await _database, idToken);
  }

  Future<String> getToken() async {
    return await _appInfo.record('user-token').get(await _database);
  }

  Future deleteLoggedInUser() async {
    await _appInfo
        .record('user')
        .delete(await _database)
        .catchError((error) {});
  }
}
