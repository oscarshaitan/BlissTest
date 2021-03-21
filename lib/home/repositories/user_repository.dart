import 'dart:convert';

import 'package:bliss_test/_core/keys.dart';
import 'package:bliss_test/home/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container.dart';

class UserRepository {
  final UserServices _userServices;
  final SharedPreferences _sharedPreferences;
  final Map<String, dynamic> _usersAvatar;

  UserRepository(
      this._userServices, this._usersAvatar, this._sharedPreferences);

  Future<String> fetchUserAvatar(String userName) async {
    if (_usersAvatar[userName] == null) {
      String userAvatarJson = _sharedPreferences.get(Keys.usersKey);
      Map<String, dynamic> usersAvatarJson = jsonDecode(userAvatarJson ?? '{}');
      if (usersAvatarJson[userName] == null) {
        String tempUser = await _userServices.fetchUserAvatar(userName);
        return _saveUserAvatar(tempUser, userName, usersAvatarJson,
            saveOnSharePreferences: true);
      } else {
        return usersAvatarJson[userName];
      }
    } else {
      return _usersAvatar[userName];
    }
  }

  String _saveUserAvatar(
      String tempUser, String userName, Map<String, dynamic> jsonSaved,
      {bool saveOnSharePreferences = false}) {
    Map<String, dynamic> userJson = jsonDecode(tempUser);
    if (saveOnSharePreferences) {
      jsonSaved.addEntries([MapEntry(userName, userJson['avatar_url'])]);
      _sharedPreferences.setString(Keys.usersKey, jsonSaved.toString());
    }
    sl.registerLazySingleton<Map<String, dynamic>>(() => jsonSaved,
        instanceName: Keys.usersKey);
    return userJson['avatar_url'];
  }
}
