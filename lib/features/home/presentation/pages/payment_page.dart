import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:two_ticket/core/constants/dependencies/injection_container.dart';
import 'package:two_ticket/features/home/data/domain/model/ask_payment_dto.dart';
import 'package:two_ticket/features/home/data/domain/model/payment_map_dto.dart';
import 'package:two_ticket/features/home/data/domain/model/user_model.dart';
import 'package:two_ticket/features/home/presentation/pages/cubit/home_cubit.dart';
import 'package:two_ticket/features/home/presentation/pages/widgets/profile_banner.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
    required this.paymentMap,
    required this.user,
  });

  final PaymentMapDTO paymentMap;
  final User user;

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  String? _selectedPaymentType;
  bool _isPaymentProcessing = false;

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('MMM yyyy').format(widget.paymentMap.fromDate);

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
                  ProfileBanner(member: widget.user.member),
                  const Text('Manage your quotas here.'),
                  const SizedBox(height: 16),
                  DropdownButton<String>(
                    value: '$formattedDate (${widget.paymentMap.price}€)',
                    items: [
                      DropdownMenuItem(
                        value: '$formattedDate (${widget.paymentMap.price}€)',
                        child: Text(
                            '$formattedDate (${widget.paymentMap.price}€)'),
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
                      _buildPaymentCard(
                          context, 'mbway', 'assets/images/mbway.png'),
                      _buildPaymentCard(
                          context, 'mb', 'assets/images/multibanco.png'),
                      _buildPaymentCard(
                          context, 'paypal', 'assets/images/paypal.png'),
                      _buildPaymentCard(
                          context, 'cards', 'assets/images/visa.png'),
                    ],
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor:
                            _isPaymentProcessing || _selectedPaymentType == null
                                ? Colors.grey
                                : Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 150,
                          vertical: 15,
                        ),
                      ),
                      onPressed: _selectedPaymentType != null &&
                              !_isPaymentProcessing
                          ? () => _processPayment(context, widget.paymentMap)
                          : null,
                      child: _isPaymentProcessing
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              'Pay',
                              style: TextStyle(color: Colors.white),
                            ),
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

  Widget _buildPaymentCard(
      BuildContext context, String paymentType, String asset) {
    bool isSelected = _selectedPaymentType == paymentType;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentType = paymentType;
          log('Selected payment type: $_selectedPaymentType');
        });
      },
      child: Card(
        color: isSelected ? Colors.blue[100] : Colors.white,
        child: Image.asset(asset, width: 80, height: 40),
      ),
    );
  }

  Future<void> _processPayment(
      BuildContext context, PaymentMapDTO paymentMap) async {
    setState(() {
      _isPaymentProcessing = true;
    });

    final askPaymentDTO = AskPaymentDTO(
      memberId: widget.user.member.id,
      paymentType: _selectedPaymentType!,
      quota: QuotaDetailsDTO(
        periodicity: paymentMap.periodicity,
        quantity: 1,
      ),
    );

    log('Attempting to process payment with DTO: $askPaymentDTO');

    try {
      await Future.any([
        context.read<HomeCubit>().askPayment(askPaymentDTO),
        Future.delayed(const Duration(seconds: 1), () {
          throw Exception('Payment processing timed out');
        }),
      ]);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successful'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isPaymentProcessing = false;
      });
    }
  }
}
