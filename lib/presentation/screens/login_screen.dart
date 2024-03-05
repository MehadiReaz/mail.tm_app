import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login/login_cubit.dart';
import '../widgets/custom_height.dart';
import '../widgets/custom_width.dart';
import 'create_account_screen.dart';

class LoginScreen extends StatelessWidget {
  final String selectedDomain;

  LoginScreen({super.key, required this.selectedDomain});

  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        addressController.text = state.address ?? '';
        passwordController.text = state.password ?? '';

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomHeight(height: 18),
                    const Center(
                      child: Text(
                        'Welcome to TEMP MAIL',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                    ),
                    const CustomHeight(height: 15),
                    const Text('Enter Email'),
                    const CustomHeight(height: 1),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: addressController,
                            onChanged: (value) {
                              context.read<LoginCubit>().addressChanged(value);
                            },
                            decoration: InputDecoration(
                                hintText: 'example@$selectedDomain'),
                          ),
                        ),
                        const CustomWidth(width: 2),
                        Text(
                          '@$selectedDomain',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    const CustomHeight(height: 2),
                    const Text('Enter Password'),
                    const CustomHeight(height: 1),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      onChanged: (value) {
                        context.read<LoginCubit>().passwordChanged(value);
                      },
                      decoration:
                          const InputDecoration(hintText: 'Enter Password'),
                      obscureText: true,
                    ),
                    const CustomHeight(height: 2),
                    ElevatedButton(
                      onPressed: () {
                        final address =
                            '${addressController.text}@$selectedDomain';
                        final password = passwordController.text;
                        context
                            .read<LoginCubit>()
                            .login(context, address, password);
                      },
                      child: const Text('Login'),
                    ),
                    const CustomHeight(height: 3),
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
                    const CustomHeight(height: 1),
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
