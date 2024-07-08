import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_ticket/core/constants/dependencies/injection_container.dart';
import 'package:two_ticket/core/constants/enums.dart';
import 'package:two_ticket/features/home/presentation/pages/cubit/home_cubit.dart';
import 'package:two_ticket/features/home/presentation/pages/payment_page.dart';
import 'package:two_ticket/features/home/presentation/pages/widgets/profile_banner.dart';
import 'package:two_ticket/features/home/presentation/pages/widgets/quotas_table.dart';

class QuotasPage extends StatelessWidget {
  const QuotasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double dh = MediaQuery.of(context).size.height;
    final double dw = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..init(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: state.status == Status.loading
              ? const Center(child: CircularProgressIndicator())
              : state.status == Status.error
                  ? Center(child: Text('Error: ${state.error}'))
                  : ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Text(
                                'Quotas',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  letterSpacing: 5,
                                  color: Color(0xFF444444),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: dw * .02),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PaymentPage(
                                          paymentMap: state.paymentMaps[0],
                                          user: state.user!,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: dw * .05,
                                      vertical: dh * .012,
                                    ),
                                  ),
                                  child: const Text(
                                    'Update Quotas',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (state.user != null)
                          Column(
                            children: [
                              ProfileBanner(member: state.user!.member),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'Manage your quotas here.',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(height: 20),
                              QuotasTable(
                                quotas: state.quotas,
                                itemsToShow: state.itemsToShow,
                              ),
                            ],
                          )
                      ],
                    ),
        ),
      ),
    );
  }
}
