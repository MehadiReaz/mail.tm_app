import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(false);

  void checkTokenAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2)); // Wait for 2 seconds

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      // Token exists, navigate to HomeScreen
      emit(true);
    } else {
      // Token doesn't exist, navigate to DomainScreen
      emit(false);
    }
  }
}
