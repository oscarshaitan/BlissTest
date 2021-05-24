import 'package:bliss_test/_core/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GoogleReposServices {
  final http.Client _client;

  GoogleReposServices(this._client);

  Future<String> fetchGoogleRepos(int page) async {
    try {
      Uri url = Uri.parse(
          'https://api.github.com/users/google/repos?page=${page.toString()}&per_page=25');
      Response response = await _client.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw FailFetchGoogleRepos();
      }
    } on Exception catch (_) {
      throw FailFetchGoogleRepos();
    }
  }
}
