
import 'package:bliss_test/_core/exceptions.dart';
import 'package:bliss_test/google_repos/models/github_repo.dart';
import 'package:bliss_test/google_repos/repositories/google_repos_repository.dart';
import 'package:bliss_test/google_repos/use_case/fetch_google_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

class MockRepo extends Mock implements GoogleReposRepository {}

void main() {
  final List<GitHubRepo> mockedAnswer = [GitHubRepo(name: 'name', url: 'url')];
  MockRepo repo;
  FetchGoogleRepos useCase;

  setUp(() {
    repo = MockRepo();
    useCase = FetchGoogleRepos(repo);
  });

  test('when useCase is called, then call the repo', () async {
    when(repo.fetchGoogleRepos(0)).thenAnswer((_) async => mockedAnswer);
    final result = await useCase(0);
    verify(repo.fetchGoogleRepos(0));

    expect(result, mockedAnswer);
  });

  test('when repo throw FailFetchGoogleRepos then throw same error', () async {
    when(repo.fetchGoogleRepos(0)).thenThrow(FailFetchGoogleRepos());
    expect(() => useCase(0), throwsA(TypeMatcher<FailFetchGoogleRepos>()));
  });
}
