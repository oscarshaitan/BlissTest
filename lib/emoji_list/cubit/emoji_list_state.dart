part of 'emoji_list_cubit.dart';

@immutable
abstract class EmojiListState {
  List<Emoji> get emojis;
}

class EmojiListInitial extends EmojiListState {
  final List<Emoji> emojis = [];
}

class EmojiListLoaded extends EmojiListState {
  final List<Emoji> emojis;

  EmojiListLoaded(this.emojis);
}

class RemovingEmoji extends EmojiListState {
  final List<Emoji> emojis;
  final String name;

  RemovingEmoji({this.emojis, this.name});
}
