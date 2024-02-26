import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/home_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getMessages() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token') ??
          ''; // Use a default value or handle accordingly

      final response = await Dio().get(
        'https://api.mail.tm/messages',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final List<dynamic> messageList = response.data['hydra:member'] ?? [];
      final List<MessageModel> messages =
          messageList.map((json) => MessageModel.fromJson(json)).toList();
      emit(MessagesLoaded(messages));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
