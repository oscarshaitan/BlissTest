
import 'package:bliss_test/_core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class EmojiServices {
  Future<String> fetchEmojis() async {
    try {
      Uri url = Uri.parse('https://api.github.com/emojis');
      Response response = await http.get(url);
      return response.body;
    } on Exception catch (_) {
      throw FailFetchEmojis();
    }
  }
}
