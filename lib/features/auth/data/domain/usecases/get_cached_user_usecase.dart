import 'package:two_ticket/features/auth/data/domain/repositories/auth_repository.dart';
import 'package:two_ticket/features/home/data/domain/model/user_model.dart';

class GetCachedUserUseCase {
  final AuthRepository repository;

  GetCachedUserUseCase(this.repository);

  Future<User?> call() {
    return repository.getCachedUser();
  }
}
