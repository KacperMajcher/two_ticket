import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:two_ticket/core/constants/enums.dart';
import 'package:two_ticket/features/home/data/domain/model/quota_dto.dart';
import 'package:two_ticket/features/home/data/domain/model/user_model.dart';
import 'package:two_ticket/features/home/data/domain/usecases/get_quota_usecase.dart';
import 'package:two_ticket/features/home/data/domain/usecases/get_user_data_usecase.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.getUserDataUseCase,
    this.getQuotasUseCase,
  ) : super(
          HomeState(
            status: Status.initial,
            user: null,
            quotas: [],
            error: '',
          ),
        );

  final GetUserDataUseCase getUserDataUseCase;
  final GetQuotasUseCase getQuotasUseCase;

  Future<void> init() async {
    try {
      emit(
        state.copyWith(
          status: Status.loading,
        ),
      );
      final updatedUser = await getUserDataUseCase();
      log(
        'User fetched successfully: $updatedUser',
      );
      final quotas = await getQuotasUseCase(
        updatedUser.cookie,
      );

      emit(
        HomeState(
          status: Status.success,
          user: updatedUser,
          quotas: quotas,
          error: '',
        ),
      );
    } catch (e) {
      log('Error in HomeCubit: $e');
      emit(
        HomeState(
          status: Status.error,
          user: null,
          quotas: [],
          error: 'Failed to fetch data: $e',
        ),
      );
    }
  }
}
