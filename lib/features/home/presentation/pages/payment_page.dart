import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_ticket/core/constants/dependencies/injection_container.dart';
import 'package:two_ticket/features/home/data/domain/model/payment_map_dto.dart';
import 'package:two_ticket/features/home/data/domain/model/ask_payment_dto.dart';
import 'package:two_ticket/features/home/data/domain/model/user_model.dart';
import 'package:two_ticket/features/home/presentation/pages/cubit/home_cubit.dart';
import 'package:two_ticket/features/home/presentation/pages/widgets/payment_button.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({
    super.key,
    required this.paymentMap,
    required this.user,
  });

  final PaymentMapDTO paymentMap;
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Quotas'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Manage your quotas here.'),
                  const SizedBox(height: 16),
                  DropdownButton<String>(
                    value: '${paymentMap.fromDate} (${paymentMap.price}€)',
                    items: [
                      DropdownMenuItem(
                        value: '${paymentMap.fromDate} (${paymentMap.price}€)',
                        child: Text(
                            '${paymentMap.fromDate} (${paymentMap.price}€)'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 16),
                  const Text('Select payment method:'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PaymentButton(
                        image: 'assets/images/mbway.png',
                        onTap: () {
                          _handlePayment(context, 'mbway');
                        },
                      ),
                      PaymentButton(
                        image: 'assets/images/multibanco.png',
                        onTap: () {
                          _handlePayment(context, 'mb');
                        },
                      ),
                      PaymentButton(
                        image: 'assets/images/paypal.png',
                        onTap: () {
                          _handlePayment(context, 'paypal');
                        },
                      ),
                      PaymentButton(
                        image: 'assets/images/visa.png',
                        onTap: () {
                          _handlePayment(context, 'cards');
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Center(
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text('Pay'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handlePayment(BuildContext context, String paymentType) {
    final askPaymentDTO = AskPaymentDTO(
      memberId: user.member.id,
      paymentType: paymentType,
      quota: QuotaDetailsDTO(
        periodicity: paymentMap.periodicity,
        quantity: 1,
      ),
    );

    context.read<HomeCubit>().askPayment(askPaymentDTO);
  }
}
