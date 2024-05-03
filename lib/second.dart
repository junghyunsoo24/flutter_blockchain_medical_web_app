import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final Map<String, dynamic> payload;

  const SecondPage({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title: ${payload['title']}'),
            Text('Body: ${payload['body']}'),
            Text('Sender: ${payload['sender']}'),
          ],
        ),
      ),
    );
  }
}