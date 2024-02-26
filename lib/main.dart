import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/blocs/domain/domain_cubit.dart';
import 'presentation/blocs/home/home_cubit.dart';
import 'presentation/blocs/login/login_cubit.dart';
import 'presentation/screens/domain_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DomainCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: MaterialApp(
        title: 'Your App',
        home: DomainScreen(),
      ),
    );
  }
}
