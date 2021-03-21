import 'package:bliss_test/_core/exceptions.dart';
import 'package:bliss_test/home/services/user_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements http.Client {}

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

  UserServices service;

  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    service = UserServices(mockHttpClient);
  });

  test('when service call fetchUserAvatar,  make the backend call', () {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(responseMocked, 200));
    service.fetchUserAvatar('userName');
    verify(mockHttpClient.get(Uri.parse('https://api.github.com/users/userName')));
  });

  test('when backend respond 200, get a String with the user data', () async {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(responseMocked, 200));
    final result = await service.fetchUserAvatar('userName');
    expect(result, responseMocked);
  });

  test('when backend respond other than 200, throw FailFetchUserAvatar', () async {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('', 500));

    expect(
            () => service.fetchUserAvatar(''), throwsA(TypeMatcher<FailFetchUserAvatar>()));
  });

  test('when fail , throw FailFetchEmojis', () async {
    when(mockHttpClient.get(any)).thenThrow(FailFetchUserAvatar());

    expect(
            () => service.fetchUserAvatar(''), throwsA(TypeMatcher<FailFetchUserAvatar>()));
  });

}
