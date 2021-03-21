import 'dart:math';

import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bliss_test/home/use_case/fetch_emojis.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FetchEmojis _fetchEmojis;
  final Random _random = Random();
  Map<String, dynamic> _emojisMap;

  HomeCubit(this._fetchEmojis) : super(HomeInitial()) {
    _init();
  }

  int _next(int min, int max) => min + _random.nextInt(max - min);

  _init() async {
    _emojisMap = await _fetchEmojis();

    emit(HomeRenderEmoji(randomEmoji: _randomEmoji(_emojisMap)));
  }

  randomEmoji() {
    emit(HomeRenderEmoji(
      randomEmoji: _randomEmoji(),
    ));
  }

  navigateToEmojiList() {
    List<Emoji> emojis = [];
    _emojisMap.forEach((key, value) {
      emojis.add(Emoji(name: key, url: value));
    });

    emit(NavigateToEmojisList(
        randomEmoji: state.randomEmoji,
        emojis: emojis,
        userAvatarUrl: state.userAvatarUrl));
  }

  searchUser(String user) {
    if (user != null && user.isNotEmpty) {
      //todo
    }
  }

  Emoji _randomEmoji([Map<String, dynamic> emojis]) {
    Map<String, dynamic> emojisLoaded = _emojisMap ?? emojis;
    int randomIndex = _next(0, emojisLoaded.values.length);
    String name = emojisLoaded.keys.toList()[randomIndex];
    String url = emojisLoaded.values.toList()[randomIndex];
    return Emoji(name: name, url: url);
  }
}
