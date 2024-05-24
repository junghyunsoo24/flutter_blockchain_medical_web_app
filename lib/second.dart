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
            Text('추가 증상: ${payload['추가 증상']}'),
            Text('추가 의약품: ${payload['추가 의약품']}'),
            Text('상세 내용: ${payload['상세 내용']}'),
          ],
        ),
      ),
    );
  }
}