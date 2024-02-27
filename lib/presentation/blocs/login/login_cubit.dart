import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/dio.dart';
import '../../screens/domain_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String address, String password) async {
    try {
      final response = await DioInstance.dio.post(
        '/token',
        data: {
          "address": address,
          "password": password,
        },
      );

      final String token = response.data['token'];
      log('Token received: $token');

      // Store the token in SharedPreferences
      loginSuccess(token);
    } catch (error) {
      // Handle errors
    }
  }

  Future<void> logout(BuildContext context) async {
    // Clear the token in SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    // Navigate back to the domain screen and remove all routes from the stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => DomainScreen(), // Replace with your domain screen
      ),
      (route) => false,
    );
  }

  void loginSuccess(String token) async {
    // Store the token in SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    log('Login Token $token');

    // Emit a state indicating successful login
    emit(LoginSuccess(token));
  }
}
