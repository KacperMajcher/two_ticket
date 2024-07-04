import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    this.userData,
  });

  final Map<String, dynamic>? userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the application, you have logged in.',
            ),
            if (userData != null)
              Text(
                'User Data: ${userData.toString()}',
              ),
          ],
        ),
      ),
    );
  }
}
