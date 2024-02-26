import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/home/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getMessages(); // Trigger fetching messages

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is MessagesLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Inbox'),
            ),
            body: ListView.builder(
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final message = state.messages[index];

                return ListTile(
                  onTap: () {
                    // Handle tapping on the email to view details
                  },
                  leading: CircleAvatar(
                    // You may want to display the sender's image here
                    backgroundColor: Colors.blue,
                    child: Text(message.from['name'][0]),
                  ),
                  title: Text(
                    message.subject,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    message.intro,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.createdAt,
                        style: TextStyle(fontSize: 12),
                      ),
                      if (!message.seen) Icon(Icons.mark_email_unread),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is HomeError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: Center(
              child: Text('Error: ${state.error}'),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading...'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
