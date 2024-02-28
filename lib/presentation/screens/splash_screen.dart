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
      child: Scaffold(
        body: Center(
            child: RichText(
          text: const TextSpan(children: [
            TextSpan(
              text: '@',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6875F5)),
            ),
            TextSpan(
              text: 'mail.',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF)),
            ),
            TextSpan(
              text: 'tm',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6875F5)),
            ),
          ]),
        )),
      ),
    );
  }
}
