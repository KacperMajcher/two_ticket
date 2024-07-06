import 'package:two_ticket/features/home/data/domain/model/ask_payment_dto.dart';
import 'package:two_ticket/features/home/data/repositories/user_repository.dart';

class AskPaymentUseCase {
  AskPaymentUseCase(this.repository);

  final UserRepository repository;

  Future<AskPaymentDTO> call(String cookie, AskPaymentDTO askPayment) {
    return repository.askPayment(cookie, askPayment);
  }
}
