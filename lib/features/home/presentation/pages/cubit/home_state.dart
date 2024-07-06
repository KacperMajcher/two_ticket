part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required Status status,
    User? user,
    required List<QuotaDTO> quotas,
    required String error,
  }) = _HomeState;
}
