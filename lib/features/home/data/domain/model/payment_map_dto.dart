import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_map_dto.freezed.dart';
part 'payment_map_dto.g.dart';

@freezed
class PaymentMapDTO with _$PaymentMapDTO {
  const factory PaymentMapDTO({
    required int id,
    required String
        periodicity,
    required DateTime fromDate,
    required DateTime toDate,
    required int price, 
  }) = _PaymentMapDTO;

  factory PaymentMapDTO.fromJson(Map<String, dynamic> json) =>
      _$PaymentMapDTOFromJson(json);
}
