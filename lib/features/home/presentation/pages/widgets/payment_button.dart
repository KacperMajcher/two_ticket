import 'package:flutter/widgets.dart';

class PaymentButton extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const PaymentButton({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(image, width: 80, height: 40),
    );
  }
}
