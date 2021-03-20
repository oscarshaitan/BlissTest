import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'emoji_list_state.dart';

class EmojiListCubit extends Cubit<EmojiListState> {
  EmojiListCubit() : super(EmojiListInitial());
  List<Emoji> _originalEmojis;

  init(List<Emoji> emojis) {
    this._originalEmojis = []..addAll(emojis);
    emit(EmojiListLoaded(emojis));
  }

  removeTile(Emoji emoji) {
    List<Emoji> newEmojis = []..addAll(state.emojis)..remove(emoji);
    emit(RemovingEmoji(emojis: newEmojis, name: emoji.name));
  }

  refreshEmojis() {
    emit(EmojiListLoaded(_originalEmojis));
  }
}
