import 'dart:convert';

import 'package:bliss_test/_core/error/exceptions.dart';
import 'package:bliss_test/_core/keys.dart';
import 'package:bliss_test/home/services/emoji_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container.dart';

class EmojisRepository {
  final SharedPreferences _sharedPreferences;
  final EmojiServices _emojiServices;
  final Map<String, dynamic> _emojis;

  EmojisRepository(this._sharedPreferences, this._emojiServices, this._emojis);

  Future<Map<String, dynamic>> fetchEmojis() async {
    if (_emojis.isEmpty) {
      String emojisJson = _sharedPreferences.get(Keys.emojisKey);

      if (emojisJson == null) {
        String tempEmojis = await _emojiServices.fetchEmojis();

        return _saveEmojisFroomString(tempEmojis, saveOnSharePreferences: true);
      } else {
        return _saveEmojisFroomString(emojisJson);
      }
    } else {
      return _emojis;
    }
  }

  Map<String, dynamic> _saveEmojisFroomString(String emojisJson,
      {bool saveOnSharePreferences = false}) {
    if (saveOnSharePreferences) {
      _sharedPreferences.setString(Keys.emojisKey, emojisJson);
    }

    Map<String, dynamic> emojisResponse = jsonDecode(emojisJson);
    sl.registerLazySingleton<Map<String, dynamic>>(() => emojisResponse,
        instanceName: Keys.emojisKey);
    return emojisResponse;
  }
}
