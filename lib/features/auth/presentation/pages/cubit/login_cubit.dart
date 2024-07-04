import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:two_ticket/core/constants/enums.dart';
import 'package:two_ticket/features/auth/data/domain/usecases/get_cached_user_usecase.dart';
import 'package:two_ticket/features/home/data/domain/usecases/get_user_data_usecase.dart';
import 'package:two_ticket/features/auth/data/domain/usecases/login_usecase.dart';
import 'package:two_ticket/features/auth/data/domain/usecases/logout_usecase.dart';
import 'package:two_ticket/features/home/data/domain/model/user_model.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCachedUserUseCase getCachedUserUseCase;
  final GetUserDataUseCase getUserDataUseCase;

  LoginCubit(
    this.loginUseCase,
    this.logoutUseCase,
    this.getCachedUserUseCase,
    this.getUserDataUseCase,
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

  Future<void> fetchUserData() async {
    final user = state.user;
    if (user != null) {
      try {
        final updatedUser = await getUserDataUseCase(user.cookie);
        emit(
          LoginState(
            status: LoginStatus.success,
            user: updatedUser,
            error: '',
          ),
        );
      } catch (e) {
        emit(
          LoginState(
            status: LoginStatus.error,
            user: null,
            error: 'Failed to fetch user data: $e',
          ),
        );
      }
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
