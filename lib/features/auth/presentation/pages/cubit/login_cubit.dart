import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:two_ticket/core/constants/enums.dart';
import 'package:two_ticket/features/auth/data/domain/model/user_model.dart';
import 'package:two_ticket/features/auth/data/domain/usecases/get_cached_user_usecase.dart';
import 'package:two_ticket/features/auth/data/domain/usecases/login_usecase.dart';
import 'package:two_ticket/features/auth/data/domain/usecases/logout_usecase.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCachedUserUseCase getCachedUserUseCase;

  LoginCubit(
    this.loginUseCase,
    this.logoutUseCase,
    this.getCachedUserUseCase,
  ) : super(
          LoginState(
            status: LoginStatus.initial,
            user: null,
            error: '',
          ),
        );

  void login(String username, String password) async {
    emit(
      LoginState(
        status: LoginStatus.connecting,
        user: null,
        error: '',
      ),
    );

    try {
      final user = await loginUseCase(username, password);
      emit(
        LoginState(
          status: LoginStatus.success,
          user: user,
          error: '',
        ),
      );
    } catch (e) {
      emit(
        LoginState(
          status: LoginStatus.error,
          user: null,
          error: 'Login failed: $e',
        ),
      );
    }
  }

  Future<void> loadUser() async {
    try {
      final user = await getCachedUserUseCase();
      if (user != null) {
        emit(
          LoginState(
            status: LoginStatus.success,
            user: user,
            error: '',
          ),
        );
      }
    } catch (e) {
      emit(
        LoginState(
          status: LoginStatus.error,
          user: null,
          error: 'Failed to load cached user: $e',
        ),
      );
    }
  }

  Future<void> logout() async {
    await logoutUseCase();
    emit(
      LoginState(
        status: LoginStatus.initial,
        user: null,
        error: '',
      ),
    );
  }
}
