part of 'avatar_list_cubit.dart';

@immutable
abstract class AvatarListState extends Equatable {
  List<ImageApp> get avatars;
}

class AvatarListInitial extends AvatarListState {
  final List<ImageApp> avatars = [];

  @override
  List<Object> get props => [];
}

class AvatarListLoaded extends AvatarListState {
  final List<ImageApp> avatars;

  AvatarListLoaded(this.avatars);

  @override
  List<Object> get props => [avatars];
}

class RemovingAvatar extends AvatarListState {
  final List<ImageApp> avatars;
  final String name;

  RemovingAvatar({this.avatars, this.name});

  @override
  List<Object> get props => [avatars, name];
}
