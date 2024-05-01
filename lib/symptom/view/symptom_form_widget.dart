// import 'package:flutter/material.dart';
// import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
//
// import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/viewModel/symptom_view_model.dart';
//
//
// class SymptomFormWidget extends StatefulWidget {
//   final SymptomViewModel viewModel;
//   final ValueChanged<List<Symptom>> onSymptomSaved;
//
//   SymptomFormWidget({
//     required this.viewModel,
//     required this.onSymptomSaved,
//   });
//
//   @override
//   _SymptomFormWidgetState createState() => _SymptomFormWidgetState();
// }
//
// class _SymptomFormWidgetState extends State<SymptomFormWidget> {
//   final _formKey = GlobalKey<FormState>();
//   late List<Symptom> _symptoms = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _symptoms.add(
//       Symptom(
//         id: 0,
//         symptom: '',
//         creationTime: DateTime.now(),
//         startDate: DateTime.now(),
//         endDate: DateTime.now(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListView.builder(
//             shrinkWrap: true,
//             itemCount: _symptoms.length,
//             itemBuilder: (context, index) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Symptom ${index + 1}',
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return '증상을 입력하고, 등록 버튼을 눌러주세요.';
//                       }
//                       return null;
//                     },
//                     onChanged: (value) {
//                       setState(() {
//                         _symptoms[index] = _symptoms[index].copyWith(
//                             symptom: value);
//                       });
//                       widget.viewModel.updateSymptom(_symptoms[index]);
//                     },
//                   ),
//                   SizedBox(height: 8.0),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             labelText: '증상 시작 날짜',
//                           ),
//                           onTap: () async {
//                             final selectedDate = await showDatePicker(
//                               context: context,
//                               initialDate: _symptoms[index].startDate,
//                               firstDate: DateTime(2000),
//                               lastDate: DateTime(2100),
//                             );
//                             if (selectedDate != null) {
//                               setState(() {
//                                 _symptoms[index] = _symptoms[index].copyWith(
//                                     startDate: selectedDate);
//                               });
//                               widget.viewModel.updateSymptom(_symptoms[index]);
//                             }
//                           },
//                           controller: TextEditingController(
//                             text: _symptoms[index].startDate.toString(),
//                           ),
//                           readOnly: true,
//                         ),
//                       ),
//                       SizedBox(width: 16.0),
//                       Expanded(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             labelText: '증상 끝 날짜',
//                           ),
//                           onTap: () async {
//                             final selectedDate = await showDatePicker(
//                               context: context,
//                               initialDate: _symptoms[index].endDate,
//                               firstDate: DateTime(2000),
//                               lastDate: DateTime(2100),
//                             );
//                             if (selectedDate != null) {
//                               setState(() {
//                                 _symptoms[index] = _symptoms[index].copyWith(
//                                     endDate: selectedDate);
//                               });
//                               widget.viewModel.updateSymptom(_symptoms[index]);
//                             }
//                           },
//                           controller: TextEditingController(
//                             text: _symptoms[index].endDate.toString(),
//                           ),
//                           readOnly: true,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16.0),
//                 ],
//               );
//             },
//           ),
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 widget.onSymptomSaved(_symptoms);
//               }
//             },
//             child: Text('Save Symptoms'),
//           ),
//         ],
//       ),
//     );
//   }
// }