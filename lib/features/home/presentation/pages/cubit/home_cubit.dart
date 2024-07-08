import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:two_ticket/core/constants/dependencies/injection_container.dart';
import 'package:two_ticket/core/constants/enums.dart';
import 'package:two_ticket/features/home/data/datasources/local_data_source.dart';
import 'package:two_ticket/features/home/data/domain/model/quota_dto.dart';
import 'package:two_ticket/features/home/data/domain/model/user_model.dart';
import 'package:two_ticket/features/home/data/domain/model/payment_map_dto.dart';
import 'package:two_ticket/features/home/data/domain/model/ask_payment_dto.dart';
import 'package:two_ticket/features/home/data/domain/usecases/get_quota_usecase.dart';
import 'package:two_ticket/features/home/data/domain/usecases/get_user_data_usecase.dart';
import 'package:two_ticket/features/home/data/domain/usecases/get_payment_maps_usecase.dart';
import 'package:two_ticket/features/home/data/domain/usecases/ask_payment_usecase.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.getUserDataUseCase,
    this.getQuotasUseCase,
    this.getPaymentMapsUseCase,
    this.askPaymentUseCase,
  ) : super(
          HomeState(
            status: Status.initial,
            user: null,
            quotas: [],
            paymentMaps: [],
            error: '',
          ),
        );

  final GetUserDataUseCase getUserDataUseCase;
  final GetQuotasUseCase getQuotasUseCase;
  final GetPaymentMapsUseCase getPaymentMapsUseCase;
  final AskPaymentUseCase askPaymentUseCase;

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
      final paymentMaps = await getPaymentMapsUseCase(
        updatedUser.cookie,
      );
      log('Payment maps fetched successfully: $paymentMaps');

      emit(
        state.copyWith(
          status: Status.success,
          user: updatedUser,
          quotas: quotas,
          paymentMaps: paymentMaps,
          error: '',
        ),
      );
    } catch (e) {
      log('Error in HomeCubit: $e');
      emit(
        state.copyWith(
          status: Status.error,
          user: null,
          quotas: [],
          paymentMaps: [],
          error: 'Failed to fetch data: $e',
        ),
      );
    }
  }

  Future<void> askPayment(AskPaymentDTO askPaymentDTO) async {
    final LocalDataSource localDataSource = getIt<LocalDataSource>();
    final cookie = await localDataSource.getCookie();
    try {
      final response = await askPaymentUseCase(
        cookie!,
        askPaymentDTO,
      );
      log('Payment requested successfully: $response');
      emit(
        state.copyWith(
          status: Status.success,
          error: '',
        ),
      );
    } catch (e) {
      log('Error requesting payment: $e');
      emit(
        state.copyWith(
          status: Status.error,
          error: 'Failed to request payment: $e',
        ),
      );
    }
  }
}
