import 'package:bliss_test/google_repos/models/github_repo.dart';
import 'package:bliss_test/google_repos/repositories/google_repos_repository.dart';

class FetchGoogleRepos {
  final GoogleReposRepository repository;

  FetchGoogleRepos(this.repository);

  Future<List<GitHubRepo>> call(int page) async {
    return await repository.fetchGoogleRepos(page);
  }
}
