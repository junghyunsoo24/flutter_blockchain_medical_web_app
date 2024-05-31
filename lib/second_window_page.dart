import 'package:flutter/material.dart';

class SecondWindowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('세부 정보 페이지'),
      ),
      body: Center(
        child: Text(
          '여기에 세부 정보를 표시합니다.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}