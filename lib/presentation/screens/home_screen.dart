import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_solution_task/presentation/screens/email_details_screen.dart';

import '../blocs/home/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getMessages(); // Trigger fetching messages

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Inbox'),
          ),
          body: _buildBody(state, context),
        );
      },
    );
  }

  Widget _buildBody(HomeState state, BuildContext context) {
    if (state is MessagesLoaded) {
      return RefreshIndicator(
        onRefresh: () async {
          context
              .read<HomeCubit>()
              .getMessages(); // Trigger fetching messages on pull-to-refresh
        },
        child: ListView.builder(
          itemCount: state.messages.length,
          itemBuilder: (context, index) {
            final message = state.messages[index];

            return ListTile(
              onTap: () {
                // Navigate to the DetailsScreen when email is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(message: message),
                  ),
                );
              },
              title: Text(message.subject),
              subtitle: Text(message.intro),
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
}
