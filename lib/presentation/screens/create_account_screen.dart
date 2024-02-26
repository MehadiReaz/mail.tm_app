// create_account_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_solution_task/presentation/screens/login_screen.dart';

import '../blocs/create_account/create_account_cubit.dart';

class CreateAccountScreen extends StatelessWidget {
  final String selectedDomain;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  CreateAccountScreen({super.key, required this.selectedDomain});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAccountCubit(),
      child: BlocBuilder<CreateAccountCubit, CreateAccountState>(
        builder: (context, state) {
          if (state is CreateAccountSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(
                  selectedDomain: selectedDomain,
                ),
              ),
            );
          }
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Create an Account',
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
                        onPressed: () {
                          final address =
                              '${addressController.text}@$selectedDomain';
                          final password = passwordController.text;
                          context
                              .read<CreateAccountCubit>()
                              .createAccount(address, password);
                        },
                        child: const Text('Create Account'),
                      ),
                      const SizedBox(height: 30),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          Center(child: Text(' Already have an account ')),
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
                          Navigator.pop(context);
                        },
                        child: const Text('Login'),
                      ),
                      if (state is CreateAccountError)
                        SizedBox(
                          height: 20,
                          child: Text(
                            state.error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
