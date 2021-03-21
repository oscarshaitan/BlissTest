part of 'google_repos_cubit.dart';

@immutable
abstract class GoogleReposState {
  List<GitHubRepo> get repos;

  int get page;
}

class GoogleReposInitial extends GoogleReposState {
  final List<GitHubRepo> repos = [];
  final int page = 1;
}

class RenderGoogleRepos extends GoogleReposState {
  final List<GitHubRepo> repos;
  final int page;

  RenderGoogleRepos({
    @required this.repos,
    @required this.page,
  });
}
