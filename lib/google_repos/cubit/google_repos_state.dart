part of 'google_repos_cubit.dart';

@immutable
abstract class GoogleReposState extends Equatable {
  List<GitHubRepo> get repos;

  int get page;
}

class GoogleReposInitial extends GoogleReposState {
  final List<GitHubRepo> repos = [];
  final int page = 1;

  @override
  List<Object> get props => [page, repos];
}

class RenderGoogleRepos extends GoogleReposState {
  final List<GitHubRepo> repos;
  final int page;

  RenderGoogleRepos({
    @required this.repos,
    @required this.page,
  });

  @override
  List<Object> get props => [page, repos];
}
