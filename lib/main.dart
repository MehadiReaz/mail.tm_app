import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app/dio.dart';
import 'presentation/screens/domain_screen.dart';

void main() {
  GetIt.I.registerSingleton<Dio>(DioInstance.dio);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DomainScreen(),
    );
  }
}
