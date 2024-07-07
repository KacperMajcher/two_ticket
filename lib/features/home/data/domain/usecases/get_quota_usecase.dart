import 'package:two_ticket/features/home/data/repositories/user_repository.dart';
import 'package:two_ticket/features/home/data/domain/model/quota_dto.dart';

class GetQuotasUseCase {
  GetQuotasUseCase(this.repository);

  final UserRepository repository;

  Future<List<QuotaDTO>> call(String cookie) async {
    return repository.getQuotas(cookie);
  }
}
