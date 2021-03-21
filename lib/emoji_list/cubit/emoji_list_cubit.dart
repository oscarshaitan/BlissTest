import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'emoji_list_state.dart';

class EmojiListCubit extends Cubit<EmojiListState> {
  EmojiListCubit() : super(EmojiListInitial());
  List<ImageApp> _originalEmojis;

  init(List<ImageApp> emojis) {
    this._originalEmojis = []..addAll(emojis);
    emit(EmojiListLoaded(emojis));
  }

  removeTile(ImageApp emoji) {
    List<ImageApp> newEmojis = []..addAll(state.emojis)..remove(emoji);
    emit(RemovingEmoji(emojis: newEmojis, name: emoji.name));
  }

  refreshEmojis() {
    emit(EmojiListLoaded(_originalEmojis));
  }
}
