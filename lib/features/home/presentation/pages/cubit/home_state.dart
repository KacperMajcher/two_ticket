part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required Status status,
    User? user,
    required String error,
  }) = _HomeState;
}
