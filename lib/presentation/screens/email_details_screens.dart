import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/email_details/email_details_cubit.dart';

class EmailDetailsScreen extends StatelessWidget {
  final String emailId;

  const EmailDetailsScreen({Key? key, required this.emailId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailDetailsCubit, EmailDetailsState>(
      listener: (context, state) {
        if (state is EmailDeleted) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () => _deleteEmail(context),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, EmailDetailsState state) {
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Subject: ${emailDetails.subject}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                emailDetails.text,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            if (emailDetails.hasAttachments)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      'Attachments:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
                          // _downloadAttachment(context, attachment.downloadUrl);
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
  }

  Future<void> _deleteEmail(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this email?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      context.read<EmailDetailsCubit>().deleteEmail(emailId);
    }
  }
}
