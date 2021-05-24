import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bliss_test/_core/repositories/user_repository.dart';

class FetchUserAvatar {
  final UserRepository repository;

  FetchUserAvatar(this.repository);

  Future<ImageApp> call(String userName) async {
    return await repository.fetchUserAvatar(userName);
  }
}
