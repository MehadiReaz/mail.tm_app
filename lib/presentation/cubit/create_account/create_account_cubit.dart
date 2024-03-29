import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/dio.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(const CreateAccountInitial());

  Future<void> createAccount(String address, String password) async {
    try {
      await DioInstance.dio.post(
        '/accounts',
        data: {
          'address': address,
          'password': password,
        },
      );
      emit(const CreateAccountSuccess());
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 422) {
        // Handle validation error
        final detailedError = error.response?.data;
        final violations = detailedError?['violations'] ?? [];
        final errorMessage = violations
            .map((violation) =>
                '${violation['propertyPath']}: ${violation['message']}')
            .join(', ');
        emit(CreateAccountError(errorMessage));
      } else {
        debugPrint("Error during account creation: $error");
        emit(const CreateAccountError('An unexpected error occurred.'));
      }
    }
  }

  void addressChanged(String address) {
    emit(CreateAccountInitial(address: address, password: state.password));
  }

  void passwordChanged(String password) {
    emit(CreateAccountInitial(address: state.address, password: password));
  }
}
