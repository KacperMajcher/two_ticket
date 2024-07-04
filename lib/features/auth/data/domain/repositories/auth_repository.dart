import 'dart:developer';

import 'package:two_ticket/features/home/data/datasources/local_data_source.dart';
import 'package:two_ticket/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:two_ticket/features/auth/data/domain/model/login_model.dart';
import 'package:two_ticket/features/home/data/domain/model/user_model.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

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

          final userDataResponse = await remoteDataSource.getUserData(
            cookie,
          );
          log(userDataResponse.data.toString());
          return User(
            username: username,
            cookie: cookie,
            userData: userDataResponse.data,
          );
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
      return User(
        username: username,
        cookie: cookie,
      );
    }

    return null;
  }
}
