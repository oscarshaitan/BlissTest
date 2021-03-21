part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  ImageApp get currentImage;
}

class HomeInitial extends HomeState {
  final ImageApp currentImage = null;
  final String userAvatarUrl = null;
}

class HomeRenderImage extends HomeState {
  final ImageApp currentImage;

  HomeRenderImage({
    @required this.currentImage,
  });
}

class NavigateToEmojisList extends HomeState {
  final ImageApp currentImage;
  final List<ImageApp> emojis;

  NavigateToEmojisList({
    @required this.currentImage,
    @required this.emojis,
  });
}

class NavigateToUsersAvatarList extends HomeState {
  final ImageApp currentImage;
  final List<ImageApp> images;

  NavigateToUsersAvatarList({
    @required this.currentImage,
    @required this.images,
  });
}

class FetchingUser extends HomeState {
  final ImageApp currentImage;
  final String userAvatarUrl;
  final List<Image> emojis;

  FetchingUser({
    @required this.currentImage,
    @required this.emojis,
    @required this.userAvatarUrl,
  });
}

class FetchError extends HomeState {
  final String error;
  final ImageApp currentImage = null;
  final String userAvatarUrl = null;

  FetchError(this.error);
}
