import 'dart:developer';
import 'package:dio/dio.dart';
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

      loginSuccess(token);
    } catch (error) {
      if (error is DioException) {
        if (error.response?.statusCode == 401) {
          // Handle invalid credentials error
          emit(const LoginError(
              'Invalid credentials. Please check your email and password.'));
        } else {
          // Handle other DioErrors
          emit(const LoginError('An unexpected error occurred.'));
        }
      } else {
        // Handle non-Dio errors
        emit(const LoginError('An unexpected error occurred.'));
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const DomainScreen(),
      ),
      (route) => false,
    );
  }

  void loginSuccess(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    log('Login Token $token');
    emit(LoginSuccess(token));
  }
}
