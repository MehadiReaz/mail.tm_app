import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/email_details/email_details_cubit.dart';
import '../cubit/home/home_cubit.dart';
import '../cubit/login/login_cubit.dart';
import 'email_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getMessages();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              'Inbox',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<LoginCubit>().logout(context);
                },
                icon: const Icon(
                  Icons.logout_outlined,
                ),
              ),
            ],
          ),
          body: _buildBody(state, context),
        );
      },
    );
  }

  Widget _buildBody(HomeState state, BuildContext context) {
    if (state is MessagesLoaded) {
      if (state.messages.isEmpty) {
        return const Center(
          child: Text('Your Inbox is empty'),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          context.read<HomeCubit>().getMessages();
        },
        child: ListView.builder(
          itemCount: state.messages.length,
          itemBuilder: (context, index) {
            final message = state.messages[index];

            return ListTile(
              onTap: () {
                _navigateToEmailDetails(context, message.id);
              },
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  message.from['name'][0],
                  //style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                message.subject,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                message.intro,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   DateFormat('dd MMM')
                  //       .format(DateTime.parse(message.createdAt)),
                  //   style: const TextStyle(fontSize: 12),
                  // ),
                  if (!message.seen) const Icon(Icons.mark_email_unread),
                ],
              ),
            );
          },
        ),
      );
    } else if (state is HomeError) {
      return Center(
        child: Text('Error: ${state.error}'),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  void _navigateToEmailDetails(BuildContext context, String emailId) {
    context.read<EmailDetailsCubit>().getEmailDetails(emailId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailDetailsScreen(emailId: emailId),
      ),
    );
  }
}
