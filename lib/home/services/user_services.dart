import 'package:bliss_test/_core/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserServices {
  final http.Client _client;

  UserServices(this._client);

  Future<String> fetchUserAvatar(String userName) async {
    try {
      Uri url = Uri.parse('https://api.github.com/users/$userName');
      Response response = await _client.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw FailFetchUserAvatar();
      }
    } on Exception catch (_) {
      throw FailFetchUserAvatar();
    }
  }
}
