// create_account_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../app/dio.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(CreateAccountInitial());

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
    } catch (e) {
      print("Error during account creation: $e");
      emit(CreateAccountError(e.toString()));
    }
  }
}
