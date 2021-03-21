import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bliss_test/avatar_list/use_case/remove_avatar_user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'avatar_list_state.dart';

class AvatarListCubit extends Cubit<AvatarListState> {
  final RemoveAvatarUser _removeAvatarUser;

  AvatarListCubit(this._removeAvatarUser) : super(AvatarListInitial());
  List<ImageApp> _originalAvatars;

  init(List<ImageApp> avatars) {
    this._originalAvatars = avatars;
    emit(AvatarListLoaded(_originalAvatars));
  }

  removeTile(ImageApp emoji) {
    List<ImageApp> newAvatars = state.avatars..remove(emoji);
    emit(RemovingAvatar(avatars: newAvatars, name: emoji.name));
    _removeAvatarUser(emoji.name);
  }
}
