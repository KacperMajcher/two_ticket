part of 'login_cubit.dart';

class LoginState {
  LoginState({
    required this.status,
    this.cookie = '',
    this.error = '',
  });
  final LoginStatus status;
  final String cookie;
  final String error;
}
