import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/splash/splash_cubit.dart';
import 'domain_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashCubit>().checkTokenAndNavigate();
    return BlocListener<SplashCubit, bool>(
      listener: (context, hasToken) {
        if (hasToken) {
          // Token exists, navigate to HomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          // Token doesn't exist, navigate to DomainScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DomainScreen(),
            ),
          );
        }
      },
      child: const Scaffold(
        body: Center(
          child: Text(
            'B',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
