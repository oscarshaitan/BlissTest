import 'package:bliss_test/_core/exceptions.dart';
import 'package:bliss_test/google_repos/service/google_repos_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  final String responseMocked = '''[
  {
    "id": 170908616,
    "node_id": "MDEwOlJlcG9zaXRvcnkxNzA5MDg2MTY=",
    "name": ".github",
    "full_name": "google/.github",
    "private": false,
    "owner": {
      "login": "google",
      "id": 1342004,
      "node_id": "MDEyOk9yZ2FuaXphdGlvbjEzNDIwMDQ=",
      "avatar_url": "https://avatars.githubusercontent.com/u/1342004?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/google",
      "html_url": "https://github.com/google",
      "followers_url": "https://api.github.com/users/google/followers",
      "following_url": "https://api.github.com/users/google/following{/other_user}",
      "gists_url": "https://api.github.com/users/google/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/google/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/google/subscriptions",
      "organizations_url": "https://api.github.com/users/google/orgs",
      "repos_url": "https://api.github.com/users/google/repos",
      "events_url": "https://api.github.com/users/google/events{/privacy}",
      "received_events_url": "https://api.github.com/users/google/received_events",
      "type": "Organization",
      "site_admin": false
    },
    "html_url": "https://github.com/google/.github",
    "description": "default configuration for @google repos",
    "fork": false,
    "url": "https://api.github.com/repos/google/.github",
    "forks_url": "https://api.github.com/repos/google/.github/forks",
    "keys_url": "https://api.github.com/repos/google/.github/keys{/key_id}",
    "collaborators_url": "https://api.github.com/repos/google/.github/collaborators{/collaborator}",
    "teams_url": "https://api.github.com/repos/google/.github/teams",
    "hooks_url": "https://api.github.com/repos/google/.github/hooks",
    "issue_events_url": "https://api.github.com/repos/google/.github/issues/events{/number}",
    "events_url": "https://api.github.com/repos/google/.github/events",
    "assignees_url": "https://api.github.com/repos/google/.github/assignees{/user}",
    "branches_url": "https://api.github.com/repos/google/.github/branches{/branch}",
    "tags_url": "https://api.github.com/repos/google/.github/tags",
    "blobs_url": "https://api.github.com/repos/google/.github/git/blobs{/sha}",
    "git_tags_url": "https://api.github.com/repos/google/.github/git/tags{/sha}",
    "git_refs_url": "https://api.github.com/repos/google/.github/git/refs{/sha}",
    "trees_url": "https://api.github.com/repos/google/.github/git/trees{/sha}",
    "statuses_url": "https://api.github.com/repos/google/.github/statuses/{sha}",
    "languages_url": "https://api.github.com/repos/google/.github/languages",
    "stargazers_url": "https://api.github.com/repos/google/.github/stargazers",
    "contributors_url": "https://api.github.com/repos/google/.github/contributors",
    "subscribers_url": "https://api.github.com/repos/google/.github/subscribers",
    "subscription_url": "https://api.github.com/repos/google/.github/subscription",
    "commits_url": "https://api.github.com/repos/google/.github/commits{/sha}",
    "git_commits_url": "https://api.github.com/repos/google/.github/git/commits{/sha}",
    "comments_url": "https://api.github.com/repos/google/.github/comments{/number}",
    "issue_comment_url": "https://api.github.com/repos/google/.github/issues/comments{/number}",
    "contents_url": "https://api.github.com/repos/google/.github/contents/{+path}",
    "compare_url": "https://api.github.com/repos/google/.github/compare/{base}...{head}",
    "merges_url": "https://api.github.com/repos/google/.github/merges",
    "archive_url": "https://api.github.com/repos/google/.github/{archive_format}{/ref}",
    "downloads_url": "https://api.github.com/repos/google/.github/downloads",
    "issues_url": "https://api.github.com/repos/google/.github/issues{/number}",
    "pulls_url": "https://api.github.com/repos/google/.github/pulls{/number}",
    "milestones_url": "https://api.github.com/repos/google/.github/milestones{/number}",
    "notifications_url": "https://api.github.com/repos/google/.github/notifications{?since,all,participating}",
    "labels_url": "https://api.github.com/repos/google/.github/labels{/name}",
    "releases_url": "https://api.github.com/repos/google/.github/releases{/id}",
    "deployments_url": "https://api.github.com/repos/google/.github/deployments",
    "created_at": "2019-02-15T18:14:38Z",
    "updated_at": "2021-03-11T06:19:04Z",
    "pushed_at": "2020-12-21T09:02:09Z",
    "git_url": "git://github.com/google/.github.git",
    "ssh_url": "git@github.com:google/.github.git",
    "clone_url": "https://github.com/google/.github.git",
    "svn_url": "https://github.com/google/.github",
    "homepage": "",
    "size": 3,
    "stargazers_count": 26,
    "watchers_count": 26,
    "language": null,
    "has_issues": true,
    "has_projects": false,
    "has_downloads": true,
    "has_wiki": false,
    "has_pages": false,
    "forks_count": 55,
    "mirror_url": null,
    "archived": false,
    "disabled": false,
    "open_issues_count": 2,
    "license": null,
    "forks": 55,
    "open_issues": 2,
    "watchers": 26,
    "default_branch": "master"
  }
]''';

  GoogleReposServices service;

  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    service = GoogleReposServices(mockHttpClient);
  });

  test('when service call fetchUserAvatar,  make the backend call', () {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(responseMocked, 200));
    service.fetchGoogleRepos(0);
    verify(mockHttpClient.get(Uri.parse(
        'https://api.github.com/users/google/repos?page=0&per_page=25')));
  });

  test('when backend respond 200, get a String with the user data', () async {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(responseMocked, 200));
    final result = await service.fetchGoogleRepos(0);
    expect(result, responseMocked);
  });

  test('when backend respond other than 200, throw FailFetchUserAvatar',
      () async {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('', 500));

    expect(() => service.fetchGoogleRepos(0),
        throwsA(TypeMatcher<FailFetchGoogleRepos>()));
  });

  test('when fail , throw FailFetchGoogleRepos', () async {
    when(mockHttpClient.get(any)).thenThrow(FailFetchGoogleRepos());

    expect(() => service.fetchGoogleRepos(0),
        throwsA(TypeMatcher<FailFetchGoogleRepos>()));
  });
}
