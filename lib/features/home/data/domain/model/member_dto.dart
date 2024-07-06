import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_dto.freezed.dart';
part 'member_dto.g.dart';

@freezed
class MemberDTO with _$MemberDTO {
  const factory MemberDTO({
    required int id,
    required String name,
    String? cardName,
    String? oldNumber,
    String? idNumber,
    String? passport,
    String? customerTaxNumber,
    required String email,
    int? memberCategoryId,
    String? code,
    String? phone,
    String? mobile,
    DateTime? birthDate,
    String? gender,
    String? imageFilename,
    String? address,
    String? postalcode,
    required String city,
    required String country,
    required DateTime sinceDate,
    DateTime? untilDate,
    String? type,
    String? inactivationMotive,
    required String status,
    bool? askedAssociation,
    bool? active,
    List<String>? ticketTypes,
  }) = _MemberDTO;

  factory MemberDTO.fromJson(Map<String, dynamic> json) =>
      _$MemberDTOFromJson(json);
}
