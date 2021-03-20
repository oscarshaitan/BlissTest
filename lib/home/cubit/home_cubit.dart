
import 'package:bliss_test/home/use_case/fetch_emojis.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FetchEmojis _fetchEmojis;

  HomeCubit(this._fetchEmojis) : super(HomeInitial()) {
    _init();
  }

  _init() async {
    await _fetchEmojis();
  }
}
