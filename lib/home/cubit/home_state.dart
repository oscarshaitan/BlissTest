part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {
  ImageApp get currentImage;
}

class HomeInitial extends HomeState {
  final ImageApp currentImage = null;

  @override
  List<Object> get props => [];
}

class HomeRenderImage extends HomeState {
  final ImageApp currentImage;

  HomeRenderImage({
    @required this.currentImage,
  });

  @override
  List<Object> get props => [currentImage];
}

class NavigateToEmojisList extends HomeState {
  final ImageApp currentImage;
  final List<ImageApp> emojis;

  NavigateToEmojisList({
    @required this.currentImage,
    @required this.emojis,
  });

  @override
  List<Object> get props => [currentImage, emojis];
}

class NavigateToUsersAvatarList extends HomeState {
  final ImageApp currentImage;
  final List<ImageApp> images;

  NavigateToUsersAvatarList({
    @required this.currentImage,
    @required this.images,
  });

  @override
  List<Object> get props => [currentImage, images];
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

  @override
  List<Object> get props => [currentImage, emojis, userAvatarUrl];
}

class FetchError extends HomeState {
  final String error;
  final ImageApp currentImage = null;
  final String userAvatarUrl = null;

  FetchError(this.error);

  @override
  List<Object> get props => [error];
}
