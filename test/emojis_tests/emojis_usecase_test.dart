import 'dart:convert';

import 'package:bliss_test/_core/exceptions.dart';
import 'package:bliss_test/home/repositories/emojis_repository.dart';
import 'package:bliss_test/home/use_case/fetch_emojis.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

class MockRepo extends Mock implements EmojisRepository {}

void main() {
  final String responseMocked =
      '{"+1": "https://github.githubassets.com/images/icons/emoji/unicode/1f44d.png?v8", "-1": "https://github.githubassets.com/images/icons/emoji/unicode/1f44e.png?v8"}';
  final Map<String, dynamic> json = jsonDecode(responseMocked);
  MockRepo repo;
  FetchEmojis useCase;

  setUp(() {
    repo = MockRepo();
    useCase = FetchEmojis(repo);
  });

  test('when useCase is called, then call the repo', () async {
    when(repo.fetchEmojis()).thenAnswer((_) async => json);
    final result = await useCase();
    verify(repo.fetchEmojis());

    expect(result, json);
  });

  test('when repo throw FailFetchEmojis then throw same error', () async {
    when(repo.fetchEmojis()).thenThrow(FailFetchEmojis());
    expect(() => useCase(), throwsA(TypeMatcher<FailFetchEmojis>()));
  });
}
