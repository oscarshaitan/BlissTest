import 'package:bliss_test/_core/repositories/user_repository.dart';

class RemoveAvatarUser {
  final UserRepository repository;

  RemoveAvatarUser(this.repository);

  void call(String username) {
    return repository.removeUserAvatar(username);
  }
}
