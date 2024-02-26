import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_solution_task/presentation/screens/create_account_screen.dart';
import 'package:qtec_solution_task/presentation/screens/home_screen.dart';

import '../blocs/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  final String selectedDomain;

  LoginScreen({super.key, required this.selectedDomain});

  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          print('Login State: $state');
          if (state is LoginSuccess) {
            print('Navigating to HomeScreen');
            Future.delayed(Duration.zero, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            });
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: addressController,
                          decoration:
                              const InputDecoration(labelText: 'Address'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(selectedDomain),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final address =
                          '${addressController.text}@$selectedDomain';
                      final password = passwordController.text;
                      context.read<LoginCubit>().login(address, password);
                    },
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
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
                    SizedBox(
                      height: 20,
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
