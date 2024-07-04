import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
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
