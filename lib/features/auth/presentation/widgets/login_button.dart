import 'package:flutter/material.dart';
import 'package:two_ticket/features/home/presentation/pages/home_page.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ),
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(
            0xFF46BBE2,
          ),
        ),
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
