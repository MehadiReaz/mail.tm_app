import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login/login_cubit.dart';
import '../widgets/custom_height.dart';
import '../widgets/custom_width.dart';
import 'create_account_screen.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  final String selectedDomain;

  const LoginScreen({super.key, required this.selectedDomain});

  @override
  Widget build(BuildContext context) {
    FocusNode passwordFocus = FocusNode();

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: _formKey,
            child: SafeArea(
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
                              //color: Colors.white,
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
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Email';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: state.addressController,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintText: 'example'),
                            ),
                          ),
                          const CustomWidth(width: 2),
                          Text(
                            '@$selectedDomain',
                            style: const TextStyle(
                                //color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const CustomHeight(height: 2),
                      const Text('Enter Password'),
                      const CustomHeight(height: 1),
                      TextFormField(
                        onChanged: (_) {
                          passwordFocus.requestFocus();
                        },
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        controller: state.passwordController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            hintText: 'Enter Password'),
                        obscureText: true,
                      ),
                      const CustomHeight(height: 2),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final address =
                                '${state.addressController.text}@$selectedDomain';
                            final password = state.passwordController.text;
                            context
                                .read<LoginCubit>()
                                .login(context, address, password);
                          }
                        },
                        child: const Text('Login'),
                      ),
                      if (state is LoginError) ...[
                        const CustomHeight(height: 2),
                        SizedBox(
                          // height: 20,
                          child: Text(
                            state.error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                      const CustomHeight(height: 3),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                                //color: Colors.white,
                                ),
                          ),
                          Center(child: Text(' Don\'t have an account? ')),
                          Expanded(
                            child: Divider(
                                //color: Colors.white,
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
          ),
        );
      },
    );
  }
}
