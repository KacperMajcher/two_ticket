import 'package:two_ticket/features/auth/data/domain/repositories/auth_repository.dart';
import 'package:two_ticket/features/home/data/domain/model/user_model.dart';

class LoginUseCase {
  LoginUseCase(
    this.repository,
  );
  
  final AuthRepository repository;

  Future<User> call(String username, String password) {
    return repository.login(username, password);
  }
}
