// create_account_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_solution_task/presentation/screens/login_screen.dart';
import 'package:qtec_solution_task/presentation/widgets/custom_height.dart';
import 'package:sizer/sizer.dart';

import '../cubit/create_account/create_account_cubit.dart';
import '../widgets/custom_width.dart';

class CreateAccountScreen extends StatelessWidget {
  final String selectedDomain;
  CreateAccountScreen({super.key, required this.selectedDomain});

  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountCubit, CreateAccountState>(
      builder: (context, state) {
        addressController.text = state.address ?? '';
        passwordController.text = state.password ?? '';
        if (state is CreateAccountSuccess) {
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(
                  selectedDomain: selectedDomain,
                ),
              ),
            );
          });
        }
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                //physics: const NeverScrollableScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomHeight(height: 18),
                      Center(
                        child: Text(
                          'Create an Account',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp),
                        ),
                      ),
                      const CustomHeight(height: 12),
                      const Text('Enter Email'),
                      const CustomHeight(height: 1),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(
                                  hintText: 'example@$selectedDomain'),
                              onChanged: (value) {
                                context
                                    .read<CreateAccountCubit>()
                                    .addressChanged(value);
                              },
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
                        onChanged: (value) {
                          context
                              .read<CreateAccountCubit>()
                              .addressChanged(value);
                        },
                        controller: passwordController,
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
                              .read<CreateAccountCubit>()
                              .createAccount(address, password);
                        },
                        child: const Text('Create Account'),
                      ),
                      const CustomHeight(height: 3),
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
                      const CustomHeight(height: 1),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Login'),
                      ),
                      if (state is CreateAccountError)
                        SizedBox(
                          // height: 20,
                          child: Text(
                            state.error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
