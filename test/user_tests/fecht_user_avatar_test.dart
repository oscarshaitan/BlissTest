import 'package:bliss_test/_core/exceptions.dart';
import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bliss_test/_core/repositories/user_repository.dart';
import 'package:bliss_test/home/use_case/fetch_user_avatar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

class MockRepo extends Mock implements UserRepository {}

void main() {
  MockRepo repo;
  FetchUserAvatar useCase;
  String responseMocked = "https://avatars.githubusercontent.com/u/9093952?v=4";
  setUp(() {
    repo = MockRepo();
    useCase = FetchUserAvatar(repo);
  });

  test('when useCase is called, then call the repo', () async {
    when(repo.fetchUserAvatar('user'))
        .thenAnswer((_) async => ImageApp(name: 'user', url: responseMocked));
    final result = await useCase('user');
    verify(repo.fetchUserAvatar('user'));

    expect(result.name, 'user');
    expect(result.url, responseMocked);
    //too add equatable to compare diractly with the type
  });

  test('when repo throw FailFetchUserAvatar then throw same error', () async {
    when(repo.fetchUserAvatar('user')).thenThrow(FailFetchUserAvatar());
    expect(() => useCase('user'), throwsA(TypeMatcher<FailFetchUserAvatar>()));
  });
}
