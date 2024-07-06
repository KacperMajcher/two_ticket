
import 'package:two_ticket/features/home/data/domain/model/payment_map_dto.dart';
import 'package:two_ticket/features/home/data/repositories/user_repository.dart';

class GetPaymentMapsUseCase {
  GetPaymentMapsUseCase(this.repository);

  final UserRepository repository;

  Future<List<PaymentMapDTO>> call(String cookie) {
    return repository.getPaymentMaps(cookie);
  }
}
