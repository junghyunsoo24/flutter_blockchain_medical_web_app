import 'package:flutter/cupertino.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/board/viewModel/board_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final boardViewModelProvider = ChangeNotifierProvider((ref) => BoardViewModel());

class BoardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(boardViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('게시물 등록'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: viewModel.selectedCategory,
                items: viewModel.categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    viewModel.setSelectedCategory(value);
                  }
                },
                decoration: InputDecoration(
                  labelText: '질문 게시판 카테고리를 선택해주세요.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30.0),
              TextField(
                decoration: InputDecoration(
                  labelText: '제목을 입력해주세요.',
                  border: OutlineInputBorder(),
                ),
                onChanged: viewModel.setTitle,
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: viewModel.selectedBodyPart,
                items: viewModel.bodyParts.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    viewModel.setSelectedSymptom(value);
                  }
                },
                decoration: InputDecoration(
                  labelText: '부위를 선택해주세요.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                maxLines: null,
                decoration: InputDecoration(
                  labelText: '증상 설명',
                  border: OutlineInputBorder(),
                ),
                onChanged: viewModel.setSymptomDescription,
              ),
              SizedBox(height: 16.0),
              TextField(
                maxLines: null,
                decoration: InputDecoration(
                  labelText: '내용',
                  border: OutlineInputBorder(),
                ),
                onChanged: viewModel.setAdditionalInfo,
              ),
              SizedBox(height: 16.0),
              // TextField(
              //   maxLines: null,
              //   decoration: InputDecoration(
              //     labelText: '나의 추가 정보',
              //     border: OutlineInputBorder(),
              //   ),
              //   onChanged: viewModel.setPersonalData,
              // ),
              SizedBox(height: 16.0),
              // Row(
              //   children: [
              //     Checkbox(
              //       value: viewModel.sharePersonalData,
              //       onChanged: (bool? value) {
              //         if (value != null) {
              //           viewModel.setSharePersonalData(value);
              //         }
              //       },
              //     ),
              //     Text('공개 여부'),
              //   ],
              // ),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.submitForm();
                  },
                  child: Text('등록'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// class BoardScreen extends StatefulWidget {
//   BoardScreen({Key? key}) : super(key: key);
//
//   @override
//   _BoardScreen createState() => _BoardScreen();
// }
//
// class _BoardScreen extends State<BoardScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('게시물 등록'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: '제목을 입력해주세요.',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _title = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Text('증상 선택: '),
//                   SizedBox(width: 8.0),
//                   DropdownButton<String>(
//                     value: _selectedSymptom,
//                     hint: Text('증상 선택'),
//                     items: _symptoms.map((String symptom) {
//                       return DropdownMenuItem<String>(
//                         value: symptom,
//                         child: Text(symptom),
//                       );
//                     }).toList(),
//                     onChanged: (String? value) {
//                       setState(() {
//                         _selectedSymptom = value!;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Text('부위 선택: '),
//                   SizedBox(width: 8.0),
//                   DropdownButton<String>(
//                     value: _selectedBodyPart,
//                     hint: Text('부위 선택'),
//                     items: _bodyParts.map((String bodyPart) {
//                       return DropdownMenuItem<String>(
//                         value: bodyPart,
//                         child: Text(bodyPart),
//                       );
//                     }).toList(),
//                     onChanged: (String? value) {
//                       setState(() {
//                         _selectedBodyPart = value!;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Text('카테고리 선택: '),
//                   SizedBox(width: 8.0),
//                   DropdownButton<String>(
//                     value: _selectedCategory,
//                     hint: Text('카테고리 선택'),
//                     items: _categories.map((String category) {
//                       return DropdownMenuItem<String>(
//                         value: category,
//                         child: Text(category),
//                       );
//                     }).toList(),
//                     onChanged: (String? value) {
//                       setState(() {
//                         _selectedCategory = value!;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               TextField(
//                 maxLines: 3,
//                 decoration: InputDecoration(
//                   labelText: '증상을 설명해주세요.',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _symptomDescription = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextField(
//                 maxLines: 3,
//                 decoration: InputDecoration(
//                   labelText: '궁금한 사항을 적어주세요.',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _additionalInfo = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Text('개인 정보 공유: '),
//                   Checkbox(
//                     value: _sharePersonalData,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         _sharePersonalData = value!;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   // Add your logic for handling the registration here
//                 },
//                 style: ButtonStyle(
//                   minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
//                 ),
//                 child: Text('등록'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
