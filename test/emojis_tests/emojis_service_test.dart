import 'package:bliss_test/_core/exceptions.dart';
import 'package:bliss_test/home/services/emoji_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  final String responseMocked =
      '{"+1": "https://github.githubassets.com/images/icons/emoji/unicode/1f44d.png?v8", "-1": "https://github.githubassets.com/images/icons/emoji/unicode/1f44e.png?v8"}';
  EmojiServices service;

  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    service = EmojiServices(mockHttpClient);
  });

  test('when service call fetchEmojis,  make the backend call', () {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(responseMocked, 200));
    service.fetchEmojis();
    verify(mockHttpClient.get(Uri.parse('https://api.github.com/emojis')));
  });

  test('when backend respond 200, get a String with the emojis', () async {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(responseMocked, 200));
    final result = await service.fetchEmojis();
    expect(result, responseMocked);
  });

  test('when backend respond other than 200, throw FailFetchEmojis', () async {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('', 500));

    expect(
        () => service.fetchEmojis(), throwsA(TypeMatcher<FailFetchEmojis>()));
  });

  test('when fail , throw FailFetchEmojis', () async {
    when(mockHttpClient.get(any)).thenThrow(FailFetchEmojis());

    expect(
        () => service.fetchEmojis(), throwsA(TypeMatcher<FailFetchEmojis>()));
  });
}
