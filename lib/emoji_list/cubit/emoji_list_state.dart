part of 'emoji_list_cubit.dart';

@immutable
abstract class EmojiListState extends Equatable {
  List<ImageApp> get emojis;
}

class EmojiListInitial extends EmojiListState {
  final List<ImageApp> emojis = [];

  @override
  List<Object> get props => [emojis];
}

class EmojiListLoaded extends EmojiListState {
  final List<ImageApp> emojis;

  EmojiListLoaded(this.emojis);

  @override
  List<Object> get props => [emojis];
}

class RemovingEmoji extends EmojiListState {
  final List<ImageApp> emojis;
  final String name;

  RemovingEmoji({this.emojis, this.name});

  @override
  List<Object> get props => [emojis];
}
