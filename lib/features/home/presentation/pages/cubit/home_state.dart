part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required Status status,
    User? user,
    required List<QuotaDTO> quotas,
    required List<PaymentMapDTO> paymentMaps,
    @Default(5) int itemsToShow,
    required String error,
  }) = _HomeState;
}
