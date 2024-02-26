import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  final String selectedDomain;

  LoginScreen({required this.selectedDomain, required domain});

  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Login'),
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
                          decoration: InputDecoration(labelText: 'Address'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(selectedDomain), // Display the selected domain
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final address =
                          '${addressController.text}@$selectedDomain';
                      final password = passwordController.text;
                      context.read<LoginCubit>().login(address, password);
                    },
                    child: Text('Login'),
                  ),
                  if (state is LoginError)
                    SizedBox(
                      height: 20,
                      child: Text(
                        state.error,
                        style: TextStyle(color: Colors.red),
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
