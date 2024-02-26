import 'package:flutter/material.dart';
import '../../data/models/home_model.dart';

class DetailsScreen extends StatelessWidget {
  final MessageModel message;

  const DetailsScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From: ${message.from['address']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Subject: ${message.subject}'),
            const SizedBox(height: 8),
            Text('Sent: ${message.createdAt}'),
            const SizedBox(height: 16),
            const Text('Message Body:'),
            const SizedBox(height: 8),
            Text(message.intro),
          ],
        ),
      ),
    );
  }
}
