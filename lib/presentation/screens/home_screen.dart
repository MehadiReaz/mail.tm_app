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
              title: Text('Home'),
            ),
            body: ListView.builder(
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.messages[index].subject),
                  // Add more details as needed
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
