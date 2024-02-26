import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/dio.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String address, String password) async {
    try {
      final response = await DioInstance.dio.post(
        '/token',
        data: {
          "address": "reaz@yogirt.com",
          "password": "12345678",
        },
      );
      emit(LoginSuccess(response.data['token']));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  void loginSuccess(String token) async {
    // Store the token in SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);

    // Emit a state indicating successful login
    emit(LoginSuccess(token));
  }
}
