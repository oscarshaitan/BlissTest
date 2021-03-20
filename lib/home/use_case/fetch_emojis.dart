import 'package:bliss_test/home/repositories/emojis_repository.dart';

class FetchEmojis {
  final EmojisRepository repository;

  FetchEmojis(this.repository);

  Future<Map<String, dynamic>> call() async {
    return await repository.fetchEmojis();
  }
}
