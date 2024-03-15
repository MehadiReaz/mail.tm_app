import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/email_details/email_details_cubit.dart';

class EmailDetailsScreen extends StatelessWidget {
  final String emailId;

  const EmailDetailsScreen({super.key, required this.emailId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Details'),
      ),
      body: BlocBuilder<EmailDetailsCubit, EmailDetailsState>(
        builder: (context, state) {
          if (state is EmailDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EmailDetailsLoaded) {
            final emailDetails = state.emailDetails;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'From: ${emailDetails.from['name']} <${emailDetails.from['address']}>',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Subject: ${emailDetails.subject}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Intro: ${emailDetails.text}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  if (emailDetails.hasAttachments)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Text(
                            'Attachments:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: emailDetails.attachments.length,
                          itemBuilder: (context, index) {
                            final attachment = emailDetails.attachments[index];
                            return ListTile(
                              title: Text(attachment.filename),
                              onTap: () {
                                _downloadAttachment(
                                    context, attachment.downloadUrl);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            );
          } else if (state is EmailDetailsError) {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          } else {
            return Container(); // Handle other states if needed
          }
        },
      ),
    );
  }

  void _downloadAttachment(BuildContext context, String downloadUrl) {
    // Implement download logic here
  }
}
