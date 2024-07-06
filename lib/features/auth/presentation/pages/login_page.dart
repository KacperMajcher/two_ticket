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

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final double dw = MediaQuery.of(context).size.width;

    final loginController = TextEditingController(text: username);
    final passwordController = TextEditingController(text: password);

    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: dw * .01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginInputField(
                  controller: loginController,
                  obscureText: false,
                  hintText: 'Login',
                ),
                LoginInputField(
                  controller: passwordController,
                  obscureText: true,
                  hintText: 'Password',
                ),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state.status == LoginStatus.success) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => HomePage(
                            member  : state.user?.member,
                          ),
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
                        onPressed: () {
                          final loginModel = LoginModel(
                            username: loginController.text,
                            password: passwordController.text,
                          );
                          context
                              .read<LoginCubit>()
                              .login(loginModel.username, loginModel.password);
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
