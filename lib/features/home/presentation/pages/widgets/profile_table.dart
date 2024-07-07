import 'package:flutter/material.dart';
import 'package:two_ticket/features/home/data/domain/model/member_dto.dart';

class ProfileTable extends StatelessWidget {
  const ProfileTable({
    super.key,
    required this.member,
  });

  final MemberDTO member;

  @override
  Widget build(BuildContext context) {
    final double dw = MediaQuery.of(context).size.width;
    final rows = [
      _tableRow('Email', member.email),
      _tableRow('Password', '************'),
      _tableRow('Name', member.name),
      _tableRow('Identification number', member.idNumber ?? 'None'),
      _tableRow('Passport', member.passport ?? 'None'),
      _tableRow('VAT Number', member.customerTaxNumber ?? 'None'),
      _tableRow('Date of birth', member.birthDate?.toIso8601String() ?? 'None'),
      _tableRow('Cell phone', member.mobile ?? 'None'),
      _tableRow('Address', member.address ?? 'None'),
      _tableRow('Gender', member.gender ?? 'None'),
      _tableRow('Postal Code', member.postalcode ?? 'None'),
      _tableRow('City', member.city),
      _tableRow('Country', member.country),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dw * .03),
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(150),
          1: FlexColumnWidth(),
        },
        border: TableBorder.all(color: Colors.grey),
        children: List<TableRow>.generate(
          rows.length,
          (index) {
            return TableRow(
              decoration: BoxDecoration(
                color: index % 2 == 0 ? Colors.white : Colors.grey[200],
              ),
              children: rows[index].children,
            );
          },
        ),
      ),
    );
  }

  TableRow _tableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(value),
        ),
      ],
    );
  }
}
