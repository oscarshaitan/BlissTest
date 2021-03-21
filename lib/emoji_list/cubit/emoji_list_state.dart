part of 'emoji_list_cubit.dart';

@immutable
abstract class EmojiListState {
  List<ImageApp> get emojis;
}

class EmojiListInitial extends EmojiListState {
  final List<ImageApp> emojis = [];
}

class EmojiListLoaded extends EmojiListState {
  final List<ImageApp> emojis;

  EmojiListLoaded(this.emojis);
}

class RemovingEmoji extends EmojiListState {
  final List<ImageApp> emojis;
  final String name;

  RemovingEmoji({this.emojis, this.name});
}
