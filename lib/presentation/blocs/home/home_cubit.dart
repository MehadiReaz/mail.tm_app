import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

import '../../../app/dio.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getMessages(String token) async {
    try {
      final response = await DioInstance.dio.get(
        '/messages',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      emit(MessagesLoaded(response.data));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
