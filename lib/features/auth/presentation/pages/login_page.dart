import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_ticket/core/constants/constants.dart';
import 'package:two_ticket/core/constants/dependencies/injection_container.dart';
import 'package:two_ticket/core/constants/enums.dart';
import 'package:two_ticket/features/auth/data/domain/model/login_model.dart';
import 'package:two_ticket/features/auth/presentation/pages/cubit/login_cubit.dart';
import 'package:two_ticket/features/auth/presentation/widgets/login_button.dart';
import 'package:two_ticket/features/auth/presentation/widgets/login_input_field.dart';
import 'package:two_ticket/features/home/presentation/pages/home_page.dart';
import 'package:two_ticket/features/home/presentation/pages/widgets/custom_app_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final double dw = MediaQuery.of(context).size.width;
    final double dh = MediaQuery.of(context).size.height;

    final loginController = TextEditingController(text: username);
    final passwordController = TextEditingController(text: password);

    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Center(
          child: Column(
            children: [
              const Image(
                image: AssetImage(
                  'assets/banner.jpg',
                ),
              ),
              SizedBox(height: dh * .2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: dw * .05),
                child: LoginInputField(
                  controller: loginController,
                  obscureText: false,
                  hintText: 'Login',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: dw * .05),
                child: LoginInputField(
                  controller: passwordController,
                  obscureText: true,
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: dh * .05),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state.status == LoginStatus.success) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                    );
                  } else if (state.status == LoginStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                    log(state.error);
                  }
                },
                builder: (context, state) {
                  if (state.status == LoginStatus.connecting) {
                    return const CircularProgressIndicator();
                  } else {
                    return LoginButton(
                      color: Colors.blue,
                      text: 'Login',
                      onPressed: () {
                        final loginModel = LoginModel(
                          username: loginController.text,
                          password: passwordController.text,
                        );
                        context.read<LoginCubit>().login(
                              loginModel.username,
                              loginModel.password,
                            );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
