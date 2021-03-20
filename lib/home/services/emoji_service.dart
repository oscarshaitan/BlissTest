import 'package:bliss_test/_core/error/exceptions.dart';
import 'package:http/http.dart';

class EmojiServices {
  final Client _client;

  EmojiServices(this._client);

  Future<String> fetchEmojis() async {
    try {
      Uri url = Uri.parse('https://api.github.com/emojis');
      Response response = await _client.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw FailFetchEmojis();
      }
    } on Exception catch (_) {
      throw FailFetchEmojis();
    }
  }
}
