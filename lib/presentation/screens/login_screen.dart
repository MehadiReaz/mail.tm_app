import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_solution_task/presentation/screens/create_account_screen.dart';
import 'package:qtec_solution_task/presentation/screens/home_screen.dart';
import 'package:sizer/sizer.dart';
// import 'package:talker_flutter/talker_flutter.dart';

import '../cubit/login/login_cubit.dart';
import '../widgets/custom_height.dart';
import '../widgets/custom_width.dart';

class LoginScreen extends StatelessWidget {
  final String selectedDomain;

  LoginScreen({super.key, required this.selectedDomain});

  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final talker = TalkerFlutter.init();
    // void showLoginErrorSnackBar(String error) {
    //   final snackBar = SnackBar(
    //     content: Text(error),
    //     backgroundColor: Colors.red,

    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }

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
                child: SingleChildScrollView(
                  //physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomHeight(height: 18),
                      Center(
                        child: Text(
                          'Welcome to TEMP MAIL',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp),
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
                        decoration:
                            const InputDecoration(hintText: 'Enter Password'),
                        obscureText: true,
                      ),
                      const CustomHeight(height: 2),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          final address =
                              '${addressController.text}@$selectedDomain';
                          final password = passwordController.text;
                          context.read<LoginCubit>().login(address, password);
                          // if (state is LoginError) {
                          //   //showLoginErrorSnackBar(state.error);
                          //   TalkerWrapper(
                          //     talker: talker,
                          //     options: const TalkerWrapperOptions(
                          //       enableExceptionAlerts: true,
                          //       errorTitle: 'error',
                          //       enableErrorAlerts: true,
                          //     ),
                          //     child: Text(state.error),
                          //   );
                          // }
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
      ),
    );
  }
}
