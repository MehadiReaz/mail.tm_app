import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/home/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  final String token;

  HomeScreen({required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is MessagesLoaded) {
            // Display your messages here.
            return Scaffold(
              appBar: AppBar(
                title: Text('Home Screen'),
              ),
              body: ListView.builder(
                itemCount: state.data['hydra:totalItems'],
                itemBuilder: (context, index) {
                  var message = state.data['hydra:member'][index];
                  return ListTile(
                    title: Text(message['subject']),
                    subtitle: Text(message['intro']),
                    // Implement other message details as needed.
                  );
                },
              ),
            );
          } else if (state is HomeError) {
            // Handle home screen loading error state.
            return Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
              body: Center(
                child: Text('Error: ${state.error}'),
              ),
            );
          } else {
            // Loading or initial state.
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
      ),
    );
  }
}
