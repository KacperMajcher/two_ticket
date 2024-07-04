import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_ticket/core/constants/constants.dart';
import 'package:two_ticket/core/constants/enums.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(
          LoginState(
            status: LoginStatus.initial,
            cookie: '',
            error: '',
          ),
        );

  void login(String username, String password) async {
    emit(
      LoginState(
        status: LoginStatus.connecting,
        cookie: '',
        error: '',
      ),
    );

    const url = apiBaseURL + endpointLogin;

    final Map<String, dynamic> data = {
      "username": username,
      "password": password,
    };

    try {
      final response = await Dio().post(
        url,
        data: data,
      );

      log('Response status: ${response.statusCode}');
      log('Response headers: ${response.headers}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        List<String>? cookies = response.headers['set-cookie'];
        String? cookie = cookies?.first;

        if (cookie != null) {
          await secureStorage.write(key: 'cookie', value: cookie);
          await secureStorage.write(key: 'username', value: username);

          emit(
            LoginState(
              status: LoginStatus.success,
              cookie: cookie,
              error: '',
            ),
          );
          log('cookie: $cookie');
        } else {
          String errorMessage =
              'Login successful but cookie not found in response';
          emit(
            LoginState(
              status: LoginStatus.success,
              cookie: '',
              error: errorMessage,
            ),
          );
        }
      } else {
        emit(
          LoginState(
            status: LoginStatus.error,
            cookie: '',
            error: 'Login failed. Status code: ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(
        LoginState(
          status: LoginStatus.error,
          cookie: '',
          error: 'Request failed: $e',
        ),
      );
    }
  }

  Future<void> loadCookie() async {
    String? cookie = await secureStorage.read(key: 'cookie');
    if (cookie != null) {
      emit(
        LoginState(
          status: LoginStatus.success,
          cookie: cookie,
          error: '',
        ),
      );
    }
  }

  Future<void> clearCookie() async {
    await secureStorage.delete(key: 'cookie');
    emit(
      LoginState(
        status: LoginStatus.initial,
        cookie: '',
        error: '',
      ),
    );
  }
}
