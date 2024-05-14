import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_solution_task/presentation/widgets/custom_height.dart';
import 'package:sizer/sizer.dart';

import '../cubit/create_account/create_account_cubit.dart';
import '../widgets/custom_width.dart';
import 'login_screen.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class CreateAccountScreen extends StatelessWidget {
  final String selectedDomain;
  const CreateAccountScreen({super.key, required this.selectedDomain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CreateAccountCubit, CreateAccountState>(
        builder: (context, state) {
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
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                //physics: const NeverScrollableScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomHeight(height: 18),
                      Center(
                        child: Text(
                          'Create an Account',
                          style: TextStyle(
                            //color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                          ),
                        ),
                      ),
                      const CustomHeight(height: 12),
                      const Text('Enter Email'),
                      const CustomHeight(height: 1),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Email';
                                }
                                return null;
                              },
                              controller: state.addressController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: 'example',
                              ),
                            ),
                          ),
                          const CustomWidth(width: 2),
                          Text(
                            '@$selectedDomain',
                            style: const TextStyle(
                              //color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const CustomHeight(height: 2),
                      const Text('Enter Password'),
                      const CustomHeight(height: 1),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        controller: state.passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          hintText: 'Enter Password',
                        ),
                        obscureText: true,
                      ),
                      const CustomHeight(height: 2),
                      if (state is CreateAccountError) ...[
                        SizedBox(
                          // height: 20,
                          child: Text(
                            state.error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        const CustomHeight(height: 2),
                      ],
                      if (state is CreateAccountSuccess) ...[
                        SizedBox(
                          // height: 20,
                          child: Text(
                            state.success!,
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                        const CustomHeight(height: 2),
                      ],
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final address =
                                '${state.addressController.text}@$selectedDomain';
                            final password = state.passwordController.text;
                            context
                                .read<CreateAccountCubit>()
                                .createAccount(context, address, password);
                          }
                        },
                        child: const Text('Create Account'),
                      ),
                      const CustomHeight(height: 3),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                                //color: Colors.white,
                                ),
                          ),
                          Center(child: Text(' Already have an account ')),
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
                          Navigator.pop(context);
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
