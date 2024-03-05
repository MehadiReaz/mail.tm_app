import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qtec_solution_task/presentation/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/dio.dart';
import '../../screens/domain_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  Future<void> login(
      BuildContext context, String address, String password) async {
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

      loginSuccess(context, token);
    } catch (error) {
      if (error is DioException) {
        if (error.response?.statusCode == 401) {
          emit(const LoginError(
              'Invalid credentials. Please check your email and password.'));
        } else {
          emit(const LoginError('An unexpected error occurred.'));
        }
      } else {
        emit(const LoginError('An unexpected error occurred.'));
      }
    }
  }

  Future<void> logout(context) async {
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

  void loginSuccess(context, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    log('Login Token $token');
    emit(LoginSuccess(token));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );
  }

  void addressChanged(String address) {
    emit(LoginInitial(address: address, password: state.password));
  }

  void passwordChanged(String password) {
    emit(LoginInitial(address: state.address, password: password));
  }
}
