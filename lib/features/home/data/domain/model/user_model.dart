import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:two_ticket/features/home/data/domain/model/member_dto.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  factory User({
    required String username,
    required String cookie,
    MemberDTO? member,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
