import 'dart:math';

import 'package:bliss_test/_core/exceptions.dart';
import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bliss_test/home/use_case/fetch_emojis.dart';
import 'package:bliss_test/home/use_case/fetch_saved_avatars.dart';
import 'package:bliss_test/home/use_case/fetch_user_avatar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FetchEmojis _fetchEmojis;
  final FetchUserAvatar _fetchUserAvatar;
  final FetchSavedAvatars _fetchSavedAvatars;
  final Random _random = Random();
  Map<String, dynamic> _emojisMap;

  HomeCubit(this._fetchEmojis, this._fetchUserAvatar, this._fetchSavedAvatars)
      : super(HomeInitial()) {
    init();
  }

  int _next(int min, int max) => min + _random.nextInt(max - min);

  init() async {
    try {
      _emojisMap = await _fetchEmojis();
      emit(HomeRenderImage(currentImage: _randomEmoji(_emojisMap)));
    } on FailFetchEmojis catch (_) {
      emit(FetchError('Something happen fetching the emojis'));
    }
  }

  randomEmoji() {
    emit(HomeRenderImage(
      currentImage: _randomEmoji(),
    ));
  }

  navigatetoAvatarList() {
    emit(NavigateToUsersAvatarList(
      currentImage: state.currentImage,
      images: _fetchSavedAvatars(),
    ));
  }

  navigateToEmojiList() {
    List<ImageApp> emojis = [];
    _emojisMap.forEach((key, value) {
      emojis.add(ImageApp(name: key, url: value));
    });

    emit(NavigateToEmojisList(
      currentImage: state.currentImage,
      emojis: emojis,
    ));
  }

  searchUser(String user) async {
    try {
      if (user != null && user.isNotEmpty) {
        ImageApp userAvatar = await _fetchUserAvatar(user);
        emit(HomeRenderImage(currentImage: userAvatar));
      }
    } on FailFetchEmojis catch (_) {
      emit(FetchError('Something happen fetching the user avatar'));
    }
  }

  ImageApp _randomEmoji([Map<String, dynamic> emojis]) {
    Map<String, dynamic> emojisLoaded = _emojisMap ?? emojis;
    int randomIndex = _next(0, emojisLoaded.values.length);
    String name = emojisLoaded.keys.toList()[randomIndex];
    String url = emojisLoaded.values.toList()[randomIndex];
    return ImageApp(name: name, url: url);
  }
}
