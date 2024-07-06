import 'package:flutter/material.dart';
import 'package:two_ticket/features/home/data/domain/model/member_dto.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    this.member,
  });

  final MemberDTO? member;

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
            if (member != null)
              Text(
                'User Data: ${member.toString()}',
              ),
          ],
        ),
      ),
    );
  }
}
