part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    required LoginStatus status,
    User? user,
    required String error,
  }) = _LoginState;
}
