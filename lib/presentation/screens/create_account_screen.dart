// create_account_screen.dart
import 'package:flutter/material.dart';
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
            appBar: AppBar(
              title: const Text('Create Account'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(labelText: 'Address'),
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
                    final address = '${addressController.text}@$selectedDomain';
                    final password = passwordController.text;
                    context
                        .read<CreateAccountCubit>()
                        .createAccount(address, password);
                  },
                  child: const Text('Create Account'),
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
          );
        },
      ),
    );
  }
}
