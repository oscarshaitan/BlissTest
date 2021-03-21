import 'package:bliss_test/_core/repositories/user_repository.dart';
import 'package:bliss_test/avatar_list/use_case/remove_avatar_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRepo extends Mock implements UserRepository {}

void main() {
  MockRepo repo;
  RemoveAvatarUser useCase;
  setUp(() {
    repo = MockRepo();
    useCase = RemoveAvatarUser(repo);
  });

  test('when useCase is called, then call the repo', () async {
    when(repo.removeUserAvatar('user')).thenAnswer((_) => null);
    useCase('user');
    verify(repo.removeUserAvatar('user'));
    //too add equatable to compare diractly with the type
  });
}
