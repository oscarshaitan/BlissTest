part of 'avatar_list_cubit.dart';

@immutable
abstract class AvatarListState {
  List<ImageApp> get avatars;
}

class AvatarListInitial extends AvatarListState {
  final List<ImageApp> avatars = [];
}

class AvatarListLoaded extends AvatarListState {
  final List<ImageApp> avatars;

  AvatarListLoaded(this.avatars);
}

class RemovingAvatar extends AvatarListState {
  final List<ImageApp> avatars;
  final String name;

  RemovingAvatar({this.avatars, this.name});
}
