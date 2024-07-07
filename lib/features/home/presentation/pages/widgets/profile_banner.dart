import 'package:flutter/material.dart';
import 'package:two_ticket/features/home/data/domain/model/member_dto.dart';

class ProfileBanner extends StatelessWidget {
  const ProfileBanner({
    super.key,
    required this.member,
  });

  final MemberDTO member;

  @override
  Widget build(BuildContext context) {
    final double dh = MediaQuery.of(context).size.height;
    final double dw = MediaQuery.of(context).size.width;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                member.imageFilename ?? '',
              ),
            ),
            SizedBox(width: dw * .03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: dh * .005),
                  Row(
                    children: [
                      Text(
                        'Associated nº: ${member.code}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: dw * .015),
                      const Text(
                        'Category: Sócio',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: dh * .01),
                  Row(
                    children: [
                      const Text(
                        'Last quota: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.check,
                        color: Colors.green[700],
                      ),
                      Text(
                        'Julho 2024',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
