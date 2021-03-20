import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '_core/keys.dart';
import 'home/cubit/home_cubit.dart';
import 'home/repositories/emojis_repository.dart';
import 'home/services/emoji_service.dart';
import 'home/use_case/fetch_emojis.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance..allowReassignment = true;

init() async {
  //USECASE
  sl.registerLazySingleton(() => FetchEmojis(sl()));

  //REPOS
  sl.registerLazySingleton(() => EmojisRepository(
      sl(), sl(), sl.get<Map<String, dynamic>>(instanceName: Keys.emojisKey)));

  //SERVICES
  sl.registerLazySingleton(() => EmojiServices(sl()));

  //CUBIT
  sl.registerFactory(() => HomeCubit(sl()));

  //GLOBAL VARS
  sl.registerLazySingleton<Map<String, dynamic>>(() => {},
      instanceName: Keys.emojisKey);

  //THIRD PARTIES
  SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  sl.registerLazySingleton(() => http.Client);
}
