import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/email_details_model.dart';

part 'email_details_state.dart';

class EmailDetailsCubit extends Cubit<EmailDetailsState> {
  EmailDetailsCubit() : super(EmailDetailsInitial());

  Future<void> getEmailDetails(String emailId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token') ?? '';
      // Patch request to update seen or unseen email
      await Dio().patch(
        'https://api.mail.tm/messages/$emailId',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/merge-patch+json',
        }),
        data: {"seen": true},
      );

      // GET request to fetch details
      final response = await Dio().get(
        'https://api.mail.tm/messages/$emailId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final emailDetails = EmailDetails.fromJson(response.data);
      emit(EmailDetailsLoaded(emailDetails));
    } catch (e) {
      log(e.toString());
      emit(EmailDetailsError('Failed to fetch email details: $e'));
    }
  }

  Future<void> deleteEmail(String emailId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token') ?? '';

      await Dio().delete(
        'https://api.mail.tm/messages/$emailId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      emit(EmailDeleted());
    } catch (e) {
      emit(EmailDetailsError('Failed to delete email: $e'));
    }
  }
}
