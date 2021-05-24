import 'dart:convert';

import 'package:bliss_test/google_repos/models/github_repo.dart';
import 'package:bliss_test/google_repos/service/google_repos_services.dart';

class GoogleReposRepository {
  final GoogleReposServices _googleReposServices;

  GoogleReposRepository(this._googleReposServices);

  Future<List<GitHubRepo>> fetchGoogleRepos(int page) async {
    String serviceResponse = await _googleReposServices.fetchGoogleRepos(page);
    List<dynamic> googleReposJsons = jsonDecode(serviceResponse);
    List<GitHubRepo> googleRepos = [];
    googleReposJsons.forEach((element) {
      googleRepos.add(
          GitHubRepo(name: element['full_name'], url: element['html_url']));
    });

    return googleRepos;
  }
}
