import 'package:two_ticket/features/auth/data/domain/model/user_model.dart';
import 'package:two_ticket/features/auth/data/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call(String username, String password) {
    return repository.login(username, password);
  }
}
