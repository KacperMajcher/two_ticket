import 'package:two_ticket/features/auth/data/domain/model/user_model.dart';
import 'package:two_ticket/features/auth/data/domain/repositories/auth_repository.dart';

class GetCachedUserUseCase {
  final AuthRepository repository;

  GetCachedUserUseCase(this.repository);

  Future<User?> call() {
    return repository.getCachedUser();
  }
}
