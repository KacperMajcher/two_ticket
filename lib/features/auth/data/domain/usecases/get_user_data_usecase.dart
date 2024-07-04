import 'package:two_ticket/features/auth/data/domain/model/user_model.dart';
import 'package:two_ticket/features/auth/data/domain/repositories/auth_repository.dart';

class GetUserDataUseCase {
  GetUserDataUseCase(
    this.repository,
  );

  final AuthRepository repository;

  Future<User> call(String cookie) {
    return repository.getUserData(cookie);
  }
}
