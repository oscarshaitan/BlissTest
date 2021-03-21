import 'dart:convert';

import 'package:bliss_test/_core/exceptions.dart';
import 'package:bliss_test/_core/keys.dart';
import 'package:bliss_test/home/repositories/emojis_repository.dart';
import 'package:bliss_test/home/services/emoji_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockService extends Mock implements EmojiServices {}

class MockShareP extends Mock implements SharedPreferences {}

void main() {
  final String responseMocked =
      '{"+1": "https://github.githubassets.com/images/icons/emoji/unicode/1f44d.png?v8", "-1": "https://github.githubassets.com/images/icons/emoji/unicode/1f44e.png?v8"}';
  MockService service;
  MockShareP shareP;
  EmojisRepository repositoryInitial;
  EmojisRepository repositoryWithGetSave;

  setUp(() {
    service = MockService();
    shareP = MockShareP();
    repositoryInitial = EmojisRepository(shareP, service, {});

    repositoryWithGetSave =
        EmojisRepository(shareP, service, jsonDecode(responseMocked));
  });

  test('when repo initial is called should call shareP adn service', () async {
    when(service.fetchEmojis()).thenAnswer((_) async => responseMocked);
    when(shareP.get(Keys.emojisKey)).thenAnswer((_) => null);
    await repositoryInitial.fetchEmojis();
    verify(shareP.get(Keys.emojisKey));
    verify(service.fetchEmojis());
    verify(shareP.setString(Keys.emojisKey, responseMocked));
  });

  test('when repo initial is called and got sP saved then return from there',
      () async {
    when(shareP.get(Keys.emojisKey)).thenAnswer((_) => responseMocked);
    await repositoryInitial.fetchEmojis();
    verify(shareP.get(Keys.emojisKey));
    verifyNever(service.fetchEmojis());
  });

  test('when repo is called and got sl saved return from there', () async {
    await repositoryWithGetSave.fetchEmojis();
    verifyNever(shareP.get(Keys.emojisKey));
  });

  test('when repo is called and service throw then throw', () async {
    when(service.fetchEmojis()).thenThrow(FailFetchEmojis());
    when(shareP.get(Keys.emojisKey)).thenAnswer((_) => null);
    expect(() async => await repositoryInitial.fetchEmojis(),
        throwsA(TypeMatcher<FailFetchEmojis>()));
  });
}
