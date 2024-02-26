import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../app/dio.dart';
import '../../../data/models/home_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getMessages() async {
    try {
      final response = await DioInstance.dio.get('/messages');
      final List<dynamic> messageList = response.data['hydra:member'] ?? [];
      final List<MessageModel> messages =
          messageList.map((json) => MessageModel.fromJson(json)).toList();
      emit(MessagesLoaded(messages));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
