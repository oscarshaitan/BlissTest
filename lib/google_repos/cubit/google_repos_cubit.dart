import 'package:bliss_test/google_repos/models/github_repo.dart';
import 'package:bliss_test/google_repos/use_case/fetch_google_repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'google_repos_state.dart';

class GoogleReposCubit extends Cubit<GoogleReposState> {
  final FetchGoogleRepos _fetchGoogleRepos;
  bool _loading = false;

  GoogleReposCubit(this._fetchGoogleRepos) : super(GoogleReposInitial()) {
    _init();
  }

  _init() async {
    List<GitHubRepo> repos = await _fetchGoogleRepos(1);
    emit(RenderGoogleRepos(repos: repos, page: 1));
  }

  loadMoreRepos() async {
    if (!_loading) {
      _loading = true;
      int actualPage = state.page;
      List<GitHubRepo> repos = await _fetchGoogleRepos(actualPage + 1);

      emit(RenderGoogleRepos(
          repos: []..addAll(state.repos)..addAll(repos), page: actualPage + 1));
      _loading = false;
    }
  }

  goToRepoPage(String url) async {
    await launch(url);
  }
}
