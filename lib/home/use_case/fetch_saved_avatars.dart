import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bliss_test/_core/repositories/user_repository.dart';

class FetchSavedAvatars {
  final UserRepository repository;

  FetchSavedAvatars(this.repository);

  List<ImageApp> call() {
    return repository.fetchSavedAvatars();
  }
}
