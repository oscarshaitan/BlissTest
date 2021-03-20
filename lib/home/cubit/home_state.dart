part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  Emoji get randomEmoji;

  Map<String, dynamic> get emojisMap;
}

class HomeInitial extends HomeState {
  final Emoji randomEmoji = null;
  final Map<String, dynamic> emojisMap = null;
}

class HomeRenderEmoji extends HomeState {
  final Emoji randomEmoji;

  final Map<String, dynamic> emojisMap;

  HomeRenderEmoji({
    @required this.randomEmoji,
    @required this.emojisMap,
  });
}

class NavigateToEmojisList extends HomeState {
  final Emoji randomEmoji;

  final Map<String, dynamic> emojisMap;
  final List<Emoji> emojis;

  NavigateToEmojisList(
      {@required this.randomEmoji,
      @required this.emojisMap,
      @required this.emojis});
}
