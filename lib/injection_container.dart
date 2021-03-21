import 'package:bliss_test/_core/repositories/user_repository.dart';
import 'package:bliss_test/home/services/user_services.dart';
import 'package:bliss_test/home/use_case/fetch_user_avatar.dart';
import 'package:bliss_test/home/use_case/fetch_saved_avatars.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '_core/keys.dart';
import 'avatar_list/cubit/avatar_list_cubit.dart';
import 'avatar_list/use_case/remove_avatar_user.dart';
import 'emoji_list/cubit/emoji_list_cubit.dart';
import 'home/cubit/home_cubit.dart';
import 'home/repositories/emojis_repository.dart';
import 'home/services/emoji_service.dart';
import 'home/use_case/fetch_emojis.dart';

final sl = GetIt.instance..allowReassignment = true;

init() async {
  //USECASE
  sl.registerLazySingleton(() => FetchEmojis(sl()));
  sl.registerLazySingleton(() => FetchUserAvatar(sl()));
  sl.registerLazySingleton(() => FetchSavedAvatars(sl()));
  sl.registerLazySingleton(() => RemoveAvatarUser(sl()));

  //REPOS
  sl.registerLazySingleton(() => EmojisRepository(
      sl(), sl(), sl.get<Map<String, dynamic>>(instanceName: Keys.emojisKey)));
  sl.registerLazySingleton(() => UserRepository(
        sl(),
        sl.get<Map<String, dynamic>>(instanceName: Keys.usersKey),
        sl(),
      ));

  //SERVICES
  sl.registerLazySingleton(() => EmojiServices(sl()));
  sl.registerLazySingleton(() => UserServices(sl()));

  //CUBIT
  sl.registerFactory(() => HomeCubit(sl(), sl(), sl()));
  sl.registerFactory(() => EmojiListCubit());
  sl.registerFactory(() => AvatarListCubit(sl()));

  //GLOBAL VARS
  sl.registerLazySingleton<Map<String, dynamic>>(() => {},
      instanceName: Keys.emojisKey);
  sl.registerLazySingleton<Map<String, dynamic>>(() => {},
      instanceName: Keys.usersKey);

  //THIRD PARTIES
  SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  sl.registerLazySingleton(() => http.Client());
}
