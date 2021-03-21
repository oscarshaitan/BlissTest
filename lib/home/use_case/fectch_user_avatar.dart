import 'package:bliss_test/home/repositories/user_repository.dart';

class FetchUserAvatar {
  final UserRepository repository;

  FetchUserAvatar(this.repository);

  Future<String> call(String userName) async {
    return await repository.fetchUserAvatar(userName);
  }
}
