import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_ticket/features/home/data/domain/model/quota_dto.dart';
import 'package:two_ticket/features/home/presentation/pages/cubit/home_cubit.dart';

class QuotasTable extends StatelessWidget {
  const QuotasTable({
    super.key,
    required this.quotas,
    required this.itemsToShow,
  });

  final List<QuotaDTO> quotas;
  final int itemsToShow;

  @override
  Widget build(BuildContext context) {
    final double dw = MediaQuery.of(context).size.width;

    List<QuotaDTO> items = quotas.take(itemsToShow).toList();

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: dw * .21,
            columns: const [
              DataColumn(
                label: Text('Quota'),
              ),
              DataColumn(
                label: Text('Value'),
              ),
              DataColumn(
                label: Text('State'),
              ),
            ],
            rows: items
                .map(
                  (quota) => DataRow(
                    cells: [
                      DataCell(
                        Text(quota.name),
                      ),
                      const DataCell(
                        Text('10,00 €'),
                      ),
                      DataCell(
                        Text(quota.status),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        if (itemsToShow < quotas.length)
          TextButton(
            onPressed: () {
              context.read<HomeCubit>().showMoreItems();
            },
            child: const Text('Show More'),
          ),
      ],
    );
  }
}
