import 'dart:convert';

import 'package:bliss_test/_core/keys.dart';
import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bliss_test/home/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container.dart';

class UserRepository {
  final UserServices _userServices;
  final SharedPreferences _sharedPreferences;
  final Map<String, dynamic> _usersAvatar;

  UserRepository(
      this._userServices, this._usersAvatar, this._sharedPreferences);

  Future<ImageApp> fetchUserAvatar(String userName) async {
    if (_usersAvatar[userName] == null) {
      String userAvatarJson = _sharedPreferences.get(Keys.usersKey);
      Map<String, dynamic> usersAvatarJson = jsonDecode(userAvatarJson ?? '{}');
      if (usersAvatarJson[userName] == null) {
        String tempUser = await _userServices.fetchUserAvatar(userName);
        return _saveUserAvatar(tempUser, userName, usersAvatarJson,
            saveOnSharePreferences: true);
      } else {
        return ImageApp(name: userName, url: usersAvatarJson[userName]);
      }
    } else {
      return ImageApp(name: userName, url: _usersAvatar[userName]);
    }
  }

  ImageApp _saveUserAvatar(
      String tempUser, String userName, Map<String, dynamic> jsonSaved,
      {bool saveOnSharePreferences = false}) {
    Map<String, dynamic> userJson = jsonDecode(tempUser);
    if (saveOnSharePreferences) {
      jsonSaved.addEntries([MapEntry(userName, userJson['avatar_url'])]);
      _sharedPreferences.setString(Keys.usersKey, jsonEncode(jsonSaved));
    }
    sl.registerLazySingleton<Map<String, dynamic>>(() => jsonSaved,
        instanceName: Keys.usersKey);
    return ImageApp(name: userName, url: userJson['avatar_url']);
  }

  List<ImageApp> fetchSavedAvatars() {
    Map<String, dynamic> usersAvatarJson;
    List<ImageApp> users = [];
    if (_usersAvatar.isEmpty) {
      String userAvatarJson = _sharedPreferences.get(Keys.usersKey);
      usersAvatarJson = jsonDecode(userAvatarJson ?? '{}');
    } else {
      usersAvatarJson = _usersAvatar;
    }

    usersAvatarJson.forEach((key, value) {
      users.add(ImageApp(name: key, url: value));
    });

    return users;
  }

  void removeUserAvatar(String username) {
    _usersAvatar.remove(username);
    sl.registerLazySingleton<Map<String, dynamic>>(() => _usersAvatar,
        instanceName: Keys.usersKey);

    String userAvatarJson = _sharedPreferences.get(Keys.usersKey);
    Map<String, dynamic> usersAvatarJson = jsonDecode(userAvatarJson ?? '{}');
    usersAvatarJson.remove(username);
    _sharedPreferences.setString(
        Keys.usersKey, jsonEncode(usersAvatarJson ?? '{}'));
  }
}
