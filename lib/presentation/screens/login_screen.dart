import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_solution_task/presentation/screens/create_account_screen.dart';
import 'package:qtec_solution_task/presentation/screens/home_screen.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../blocs/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  final String selectedDomain;

  LoginScreen({super.key, required this.selectedDomain});

  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final talker = TalkerFlutter.init();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          debugPrint('Login State: $state');
          if (state is LoginSuccess) {
            debugPrint('Navigating to HomeScreen');
            Future.delayed(Duration.zero, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            });
          }
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        'Welcome to TEMP MAIL',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 26),
                      ),
                    ),
                    const SizedBox(height: 80),
                    const Text('Enter Email'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: addressController,
                            decoration: InputDecoration(
                                hintText: 'example@$selectedDomain'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '@$selectedDomain',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Enter Password'),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      decoration:
                          const InputDecoration(hintText: 'Enter Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        final address =
                            '${addressController.text}@$selectedDomain';
                        final password = passwordController.text;
                        context.read<LoginCubit>().login(address, password);
                      },
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Center(child: Text(' Don\'t have an account? ')),
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateAccountScreen(
                              selectedDomain: selectedDomain,
                            ),
                          ),
                        );
                      },
                      child: const Text('Create Account'),
                    ),
                    if (state is LoginError)
                      TalkerWrapper(
                          talker: talker,
                          options: const TalkerWrapperOptions(
                            enableExceptionAlerts: true,
                            errorTitle: 'error',
                            enableErrorAlerts: true,
                          ),
                          child: Text(state.error)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
