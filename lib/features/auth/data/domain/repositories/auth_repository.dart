import 'package:two_ticket/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:two_ticket/features/auth/data/domain/model/login_model.dart';
import 'package:two_ticket/features/home/data/datasources/local_data_source.dart';
import 'package:two_ticket/features/home/data/domain/model/user_model.dart';
import 'package:two_ticket/features/home/data/domain/usecases/get_user_data_usecase.dart';
import 'package:two_ticket/features/home/data/repositories/user_repository.dart';

class AuthRepository {
  AuthRepository(
    this.getUserDataUseCase, {
    required this.remoteDataSource,
    required this.localDataSource,
    required this.userRepository,
  });

  final AuthRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final UserRepository userRepository;
  final GetUserDataUseCase getUserDataUseCase;

  Future<User> login(
    String username,
    String password,
  ) async {
    final loginModel = LoginModel(
      username: username,
      password: password,
    );

    try {
      final response = await remoteDataSource.login(
        loginModel.toJson(),
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 204) {
        List<String>? cookies = response.response.headers['set-cookie'];
        String? cookie = cookies?.first;

        if (cookie != null) {
          await localDataSource.saveCookie(cookie);
          await localDataSource.saveUsername(username);

          final user = await getUserDataUseCase();

          return user;
        } else {
          throw Exception('Login successful but cookie not found in response');
        }
      } else {
        throw Exception(
            'Login failed. Status code: ${response.response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request failed: $e');
    }
  }

  Future<void> logout() async {
    await localDataSource.clearCookie();
    await localDataSource.clearUsername();
  }

  Future<User?> getCachedUser() async {
    final cookie = await localDataSource.getCookie();
    final username = await localDataSource.getUsername();

    if (cookie != null && username != null) {
      try {
        final user = await getUserDataUseCase();
        return user;
      } catch (e) {
        throw Exception(
            'Failed to fetch user data with cached credentials: $e');
      }
    }

    return null;
  }
}
