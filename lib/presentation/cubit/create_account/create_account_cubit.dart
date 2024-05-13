import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/dio.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(CreateAccountInitial());
  Future<void> createAccount(context, String address, String password) async {
    try {
      await DioInstance.dio.post(
        '/accounts',
        data: {
          'address': address,
          'password': password,
        },
      );
      createAccountSuccess(context);
      // emit(CreateAccountSuccess());
    } catch (error) {
      if (error is DioException) {
        if (error.response?.statusCode == 422) {
          emit(CreateAccountError('An unexpected error occurred.'));
        }
      } else {
        emit(CreateAccountError('An unexpected error occurred.'));
      }
    }
  }

  Future<void> createAccountSuccess(context) async {}
}
