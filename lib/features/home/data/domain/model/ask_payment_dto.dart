import 'package:freezed_annotation/freezed_annotation.dart';

part 'ask_payment_dto.freezed.dart';
part 'ask_payment_dto.g.dart';

@freezed
class AskPaymentDTO with _$AskPaymentDTO {
  const factory AskPaymentDTO({
    required int memberId,
    required String paymentType,
    required QuotaDetailsDTO quota,
  }) = _AskPaymentDTO;

  factory AskPaymentDTO.fromJson(Map<String, dynamic> json) =>
      _$AskPaymentDTOFromJson(json);
}

@freezed
class QuotaDetailsDTO with _$QuotaDetailsDTO {
  const factory QuotaDetailsDTO({
    required String periodicity,
    required int quantity,
  }) = _QuotaDetailsDTO;

  factory QuotaDetailsDTO.fromJson(Map<String, dynamic> json) =>
      _$QuotaDetailsDTOFromJson(json);
}
