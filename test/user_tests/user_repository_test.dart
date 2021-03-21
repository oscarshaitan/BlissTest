import 'dart:convert';

import 'package:bliss_test/_core/exceptions.dart';
import 'package:bliss_test/_core/keys.dart';
import 'package:bliss_test/home/repositories/user_repository.dart';
import 'package:bliss_test/home/services/user_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockService extends Mock implements UserServices {}

class MockShareP extends Mock implements SharedPreferences {}

void main() {
  final String responseMocked = '''{
  "login": "oscarshaitan",
  "id": 9093952,
  "node_id": "MDQ6VXNlcjkwOTM5NTI=",
  "avatar_url": "https://avatars.githubusercontent.com/u/9093952?v=4",
  "gravatar_id": "",
  "url": "https://api.github.com/users/oscarshaitan",
  "html_url": "https://github.com/oscarshaitan",
  "followers_url": "https://api.github.com/users/oscarshaitan/followers",
  "following_url": "https://api.github.com/users/oscarshaitan/following{/other_user}",
  "gists_url": "https://api.github.com/users/oscarshaitan/gists{/gist_id}",
  "starred_url": "https://api.github.com/users/oscarshaitan/starred{/owner}{/repo}",
  "subscriptions_url": "https://api.github.com/users/oscarshaitan/subscriptions",
  "organizations_url": "https://api.github.com/users/oscarshaitan/orgs",
  "repos_url": "https://api.github.com/users/oscarshaitan/repos",
  "events_url": "https://api.github.com/users/oscarshaitan/events{/privacy}",
  "received_events_url": "https://api.github.com/users/oscarshaitan/received_events",
  "type": "User",
  "site_admin": false,
  "name": "Oscar Tigreros",
  "company": null,
  "blog": "",
  "location": null,
  "email": null,
  "hireable": true,
  "bio": null,
  "twitter_username": null,
  "public_repos": 15,
  "public_gists": 1,
  "followers": 2,
  "following": 7,
  "created_at": "2014-10-08T21:09:14Z",
  "updated_at": "2021-03-20T14:42:22Z"
}''';

  String spResponseMocked =
      "{\"user\": \"https://avatars.githubusercontent.com/u/9093952?v=4\"}";
  MockService service;
  MockShareP shareP;
  UserRepository repositoryInitial;
  UserRepository repositoryWithGetSave;

  setUp(() {
    service = MockService();
    shareP = MockShareP();
    repositoryInitial = UserRepository(service, {}, shareP);

    repositoryWithGetSave =
        UserRepository(service, jsonDecode(spResponseMocked), shareP);
  });

  test('when repo initial is called should call shareP adn service', () async {
    when(service.fetchUserAvatar(any)).thenAnswer((_) async => responseMocked);
    when(shareP.get(Keys.usersKey)).thenAnswer((_) => null);
    await repositoryInitial.fetchUserAvatar('user');
    verify(shareP.get(Keys.usersKey));
    verify(service.fetchUserAvatar('user'));
    verify(shareP.setString(Keys.usersKey,
        "{user: https://avatars.githubusercontent.com/u/9093952?v=4}"));
  });

  test('when repo initial is called and got sP saved then return from there',
      () async {
    when(shareP.get(Keys.usersKey)).thenAnswer((_) => spResponseMocked);
    await repositoryInitial.fetchUserAvatar('user');
    verify(shareP.get(Keys.usersKey));
    verifyNever(service.fetchUserAvatar('user'));
  });

  test('when repo is called and got sl saved return from there', () async {
    await repositoryWithGetSave.fetchUserAvatar('user');
    verifyNever(shareP.get(Keys.usersKey));
  });

  test('when repo is called and service throw then throw', () async {
    when(service.fetchUserAvatar('user')).thenThrow(FailFetchUserAvatar());
    when(shareP.get(Keys.emojisKey)).thenAnswer((_) => null);
    expect(() async => await repositoryInitial.fetchUserAvatar('user'),
        throwsA(TypeMatcher<FailFetchUserAvatar>()));
  });
}
