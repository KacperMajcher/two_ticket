import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:two_ticket/core/constants/enums.dart';
import 'package:two_ticket/features/auth/data/domain/usecases/get_user_data_usecase.dart';
import 'package:two_ticket/features/auth/presentation/data/domain/model/user_model.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.getUserDataUseCase,
  ) : super(
          HomeState(
            status: Status.initial,
            user: null,
            error: '',
          ),
        );

  final GetUserDataUseCase getUserDataUseCase;

  Future<void> fetchUserData() async {
    final user = state.user;
    if (user != null) {
      try {
        final updatedUser = await getUserDataUseCase(
          user.cookie,
        );
        emit(
          HomeState(
            status: Status.success,
            user: updatedUser,
            error: '',
          ),
        );
      } catch (e) {
        emit(
          HomeState(
            status: Status.error,
            user: null,
            error: 'Failed to fetch user data: $e',
          ),
        );
      }
    }
  }
}
