import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final Map<String, dynamic> payload;

  const SecondPage({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('전문가 텍스트 화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('전문의: ${payload['전문의 이름']}'),
            Text('제목: ${payload['제목']}'),
            Text('내용: ${payload['내용']}'),
          ],
        ),
      ),
    );
  }
}