import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bliss_test/avatar_list/cubit/avatar_list_cubit.dart';
import 'package:bliss_test/avatar_list/use_case/remove_avatar_user.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUseCase extends Mock implements RemoveAvatarUser {}

void main() {
  MockUseCase useCase;
  AvatarListCubit cubit;

  setUp(() {
    useCase = MockUseCase();
    cubit = AvatarListCubit(useCase);
  });

  test('call the RemoveAvatarUser when removeTile is called', () async {
    when(useCase('user')).thenAnswer((_) => null);
    cubit.removeTile(ImageApp(name: 'user', url: 'url'));
    verify(useCase('user'));
  });

  blocTest(
    'emits [] when nothing is added',
    build: () => AvatarListCubit(useCase),
    expect: () => [],
  );

  blocTest(
    'emits [AvatarListLoaded] when init is called',
    build: () => AvatarListCubit(useCase),
    act: (AvatarListCubit cubit) => cubit.init([]),
    expect: () => [AvatarListLoaded([])],
  );

  blocTest(
    'emits [AvatarListLoaded,RemovingAvatar] when removeTile is called',
    build: () => AvatarListCubit(useCase),
    act: (AvatarListCubit cubit) => cubit
      ..init([])
      ..removeTile(ImageApp(name: 'name', url: 'url')),
    expect: () =>
        [AvatarListLoaded([]), RemovingAvatar(avatars: [], name: 'name')],
  );
}
