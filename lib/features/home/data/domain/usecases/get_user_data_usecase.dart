import 'package:two_ticket/features/home/data/domain/model/user_model.dart';
import 'package:two_ticket/features/home/data/repositories/user_repository.dart';

class GetUserDataUseCase {
  GetUserDataUseCase(
    this.repository,
  );

  final UserRepository repository;

  Future<User> call() {
    return repository.getUserData();
  }
}
