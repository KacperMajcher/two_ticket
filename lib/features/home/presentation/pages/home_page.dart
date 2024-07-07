import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_ticket/core/constants/dependencies/injection_container.dart';
import 'package:two_ticket/core/constants/enums.dart';
import 'package:two_ticket/features/home/presentation/pages/cubit/home_cubit.dart';
import 'package:two_ticket/features/home/presentation/pages/payment_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..init(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Home page'),
          ),
          body: Center(
            child: state.status == Status.loading
                ? const CircularProgressIndicator()
                : state.status == Status.error
                    ? Text(
                        'Error: ${state.error}',
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Welcome to the application, you have logged in.',
                          ),
                          if (state.user != null)
                            Text(
                              'User Name: ${state.user!.member.name}',
                            ),
                          Container(
                            height: 200,
                            color: Colors.blueGrey,
                            child: ListView.builder(
                              itemCount: state.quotas.length,
                              itemBuilder: (context, index) {
                                final quota = state.quotas[index];
                                return ListTile(
                                  title: Text(quota.name),
                                  subtitle: Text(quota.status),
                                  onTap: () {},
                                );
                              },
                            ),
                          ),
                          Container(
                            height: 200,
                            color: Colors.greenAccent,
                            child: ListView.builder(
                              itemCount: state.paymentMaps.length,
                              itemBuilder: (context, index) {
                                final paymentMap = state.paymentMaps[index];
                                return ListTile(
                                  title: Text(paymentMap.periodicity),
                                  subtitle: Text('${paymentMap.price} €'),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PaymentPage(
                                          paymentMap: paymentMap,
                                          user: state.user!,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
