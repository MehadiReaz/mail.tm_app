import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/email_details_model.dart';

part 'email_details_state.dart';

class EmailDetailsCubit extends Cubit<EmailDetailsState> {
  EmailDetailsCubit() : super(EmailDetailsInitial());

  Future<void> getEmailDetails(String emailId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token') ?? '';

      final response = await Dio().get(
        'https://api.mail.tm/messages/$emailId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final emailDetails = EmailDetails.fromJson(response.data);
      emit(EmailDetailsLoaded(emailDetails));
    } catch (e) {
      emit(EmailDetailsError('Failed to fetch email details: $e'));
    }
  }
}
