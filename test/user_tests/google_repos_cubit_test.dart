import 'package:bliss_test/google_repos/cubit/google_repos_cubit.dart';
import 'package:bliss_test/google_repos/use_case/fetch_google_repositories.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUseCase extends Mock implements FetchGoogleRepos {}

void main() {
  MockUseCase useCase;
  GoogleReposCubit cubit;

  setUp(() {
    useCase = MockUseCase();
    cubit = GoogleReposCubit(useCase, () {});
  });

  test('call the FetchGoogleRepos when inits', () async {
    when(useCase.call(1)).thenAnswer((_) async => []);

    verify(useCase.call(1));
  });

  test('call the FetchGoogleRepos when inits', () async {
    when(useCase.call(any)).thenAnswer((_) async => []);
    await cubit.loadMoreRepos();
    verify(useCase.call(2));
  });

  blocTest(
    'emits RenderGoogleRepos when nothing is added',
    build: () => GoogleReposCubit(useCase, () {}),
    expect: () => [RenderGoogleRepos(repos: null, page: 1)],
  );

  blocTest(
    'emits RenderGoogleRepos twice when loadMoreRepos is added',
    build: () => GoogleReposCubit(useCase, () {}),
    act: (GoogleReposCubit cubit) => cubit.loadMoreRepos(),
    expect: () => [
      RenderGoogleRepos(repos: null, page: 1),
      RenderGoogleRepos(repos: [], page: 2)
    ],
  );
}
