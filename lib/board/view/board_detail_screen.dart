import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/model/question.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_edit_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/view/board_screen.dart';

import 'comment_insert_view.dart';
import 'comment_view.dart';

class BoardDetailScreen extends StatelessWidget {
  final Question question;
  final bool? isMyPost;

  const BoardDetailScreen({super.key, required this.question, this.isMyPost,});

  @override
  Widget build(BuildContext context) {
    final personalData = question.personalData as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text('${question.title} 상세 내용'),
        backgroundColor: Colors.blue[50],
        elevation: 0,
        actions: [
          if (isMyPost == true) // Check if isMyPost is true
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Icon(Icons.edit), // Use the appropriate icon for "수정"
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BoardEditScreen(question: question),
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              '${question.category}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '작성자: ${question.uid}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                '제목: ${question.title}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.medical_services,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      '증상: ${question.symptom}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.description,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      '내용: ${question.content}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              if (personalData != null) ...[
                const SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.person_outline,
                      color: Colors.blue,
                      size: 24.0,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '나이: ${personalData['age']}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '성별: ${personalData['gender']}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '질병: ${personalData['disease']}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '복용약: ${personalData['medication']}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16.0),
              CommentInsertView(questionId: question.id),
              // const SizedBox(height: 8.0),
              // CommentView(questionId:question.id),
            ],
          ),
        ),
      ),
    );
  }
}
