import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_ticket/core/constants/dependencies/injection_container.dart';
import 'package:two_ticket/features/home/presentation/pages/cubit/home_cubit.dart';
import 'package:two_ticket/features/home/presentation/pages/quotas_page.dart';
import 'package:two_ticket/features/home/presentation/pages/widgets/custom_app_bar.dart';
import 'package:two_ticket/features/home/presentation/pages/widgets/profile_banner.dart';
import 'package:two_ticket/features/home/presentation/pages/widgets/profile_table.dart';
import 'package:two_ticket/features/utils/text_suffix.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double dh = MediaQuery.of(context).size.height;
    final double dw = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..init(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAppBar(),
            body: Column(
              children: [
                const Image(
                  image: AssetImage(
                    'assets/banner.jpg',
                  ),
                ),
                SizedBox(height: dh * .03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: dw * .02),
                      child: const Text(
                        'Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          letterSpacing: 5,
                          color: Color(0xFF444444),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: dw * .02),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const QuotasPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: dw * .12,
                            vertical: dh * .012,
                          ),
                        ),
                        child: const Text(
                          'Quotas',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.user != null) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: dw * .03),
                    child: Row(
                      children: [
                        Text(
                          'Hello ',
                          style: suffix(
                              12.0, const Color(0xFF444444), FontWeight.normal),
                        ),
                        Text(
                          state.user!.member.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF444444),
                          ),
                        ),
                        Text(
                          ', welcome to your customer area.',
                          style: suffix(
                              12.0, const Color(0xFF444444), FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ProfileTable(member: state.user!.member),
                  ProfileBanner(member: state.user!.member),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
