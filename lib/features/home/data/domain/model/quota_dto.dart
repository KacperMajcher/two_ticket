import 'package:freezed_annotation/freezed_annotation.dart';

part 'quota_dto.freezed.dart';
part 'quota_dto.g.dart';

@freezed
class QuotaDTO with _$QuotaDTO {
  const factory QuotaDTO({
    required int id,
    required String name,
    required String status,
  }) = _QuotaDTO;

  factory QuotaDTO.fromJson(Map<String, dynamic> json) =>
      _$QuotaDTOFromJson(json);
}
