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

  HomeCubit(this._fetchEmojis) : super(HomeInitial()) {
    _init();
  }

  int _next(int min, int max) => min + _random.nextInt(max - min);

  _init() async {
    Map<String, dynamic> emojis = await _fetchEmojis();

    emit(HomeRenderEmoji(randomEmoji: _randomEmoji(emojis), emojisMap: emojis));
  }

  randomEmoji() {
    emit(HomeRenderEmoji(
      emojisMap: state.emojisMap,
      randomEmoji: _randomEmoji(),
    ));
  }

  navigateToEmojiList() {
    List<Emoji> emojis = [];
    state.emojisMap.forEach((key, value) {
      emojis.add(Emoji(name: key, url: value));
    });

    emit(NavigateToEmojisList(
        randomEmoji: state.randomEmoji,
        emojisMap: state.emojisMap,
        emojis: emojis));
  }

  Emoji _randomEmoji([Map<String, dynamic> emojis]) {
    Map<String, dynamic> emojisLoaded = state.emojisMap ?? emojis;
    int randomIndex = _next(0, emojisLoaded.values.length);
    String name = emojisLoaded.keys.toList()[randomIndex];
    String url = emojisLoaded.values.toList()[randomIndex];
    return Emoji(name: name, url: url);
  }
}
