import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../app/dio.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String address, String password) async {
    try {
      final response = await DioInstance.dio.post(
        '/token',
        data: {
          "address": "$address",
          "password": "$password",
        },
      );
      emit(LoginSuccess(response.data['token']));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
