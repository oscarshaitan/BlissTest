part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  Emoji get randomEmoji;

  String get userAvatarUrl;
}

class HomeInitial extends HomeState {
  final Emoji randomEmoji = null;
  final String userAvatarUrl = null;
}

class HomeRenderEmoji extends HomeState {
  final Emoji randomEmoji;

  final String userAvatarUrl = null;

  HomeRenderEmoji({
    @required this.randomEmoji,
  });
}

class NavigateToEmojisList extends HomeState {
  final Emoji randomEmoji;
  final String userAvatarUrl;
  final List<Emoji> emojis;

  NavigateToEmojisList({
    @required this.randomEmoji,
    @required this.emojis,
    @required this.userAvatarUrl,
  });
}

class HomeRenderUser extends HomeState {
  final Emoji randomEmoji = null;

  final String userAvatarUrl;

  HomeRenderUser({
    @required this.userAvatarUrl,
  });
}
