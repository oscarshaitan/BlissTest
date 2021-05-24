import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bliss_test/emoji_list/cubit/emoji_list_cubit.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  blocTest(
    'emits [] when nothing is added',
    build: () => EmojiListCubit(),
    expect: () => [],
  );

  blocTest(
    'emits [EmojiListLoaded] when init is called empty',
    build: () => EmojiListCubit(),
    act: (EmojiListCubit cubit) => cubit.init([]),
    expect: () => [EmojiListLoaded([])],
  );

  blocTest(
    'emits [EmojiListLoaded] when init is called with data',
    build: () => EmojiListCubit(),
    act: (EmojiListCubit cubit) =>
        cubit.init([ImageApp(name: 'name', url: 'url')]),
    expect: () => [
      EmojiListLoaded([ImageApp(name: 'name', url: 'url')])
    ],
  );

  blocTest(
    'emits [RemovingEmoji] when removeTile is called without data',
    build: () => EmojiListCubit(),
    act: (EmojiListCubit cubit) =>
        cubit.removeTile(ImageApp(name: 'name', url: 'url')),
    expect: () => [RemovingEmoji(emojis: [], name: 'name')],
  );

  blocTest(
    'emits [RemovingEmoji] when removeTile is called with data',
    build: () => EmojiListCubit(),
    act: (EmojiListCubit cubit) => cubit
      ..init([
        ImageApp(name: 'name', url: 'url'),
        ImageApp(name: 'name2', url: 'url2')
      ])
      ..removeTile(ImageApp(name: 'name', url: 'url')),
    expect: () => [
      EmojiListLoaded([
        ImageApp(name: 'name', url: 'url'),
        ImageApp(name: 'name2', url: 'url2')
      ]),
      RemovingEmoji(
          emojis: [ImageApp(name: 'name2', url: 'url2')], name: 'name')
    ],
  );

  blocTest(
    'emits [EmojiListLoaded] when refreshEmojis is called without data',
    build: () => EmojiListCubit(),
    act: (EmojiListCubit cubit) => cubit.refreshEmojis(),
    expect: () => [EmojiListLoaded(null)],
  );

  blocTest(
    'emits [EmojiListLoaded] when refreshEmojis is called with data',
    build: () => EmojiListCubit(),
    act: (EmojiListCubit cubit) => cubit
      ..init([ImageApp(name: 'name', url: 'url')])
      ..refreshEmojis(),
    expect: () => [
      EmojiListLoaded([ImageApp(name: 'name', url: 'url')])
    ],
  );
}
