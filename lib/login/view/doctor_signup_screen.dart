import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../database/drift_database.dart';

class DoctorSignupScreen extends StatefulWidget {
  const DoctorSignupScreen({Key? key}) : super(key: key);


  @override
  _DoctorSignupScreenState createState() => _DoctorSignupScreenState();
}

class _DoctorSignupScreenState extends State<DoctorSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _userID, _userPW, _name, _field, _hospital, _introduction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'User ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your user ID';
                  }
                  return null;
                },
                onSaved: (value) => _userID = value,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) => _userPW = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Field'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your field';
                  }
                  return null;
                },
                onSaved: (value) => _field = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Hospital'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your hospital';
                  }
                  return null;
                },
                onSaved: (value) => _hospital = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Introduction'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your introduction';
                  }
                  return null;
                },
                onSaved: (value) => _introduction = value,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final db = MyDatabase();

                    await db.addDoctor(DoctorsCompanion(
                        userID: Value(_userID!),
                        userPW: Value(_userPW!),
                        name: Value(_name!),
                        field: Value(_field!),
                        hospital: Value(_hospital!),
                        introduction: Value(_introduction!)
                    ));

                    Navigator.pop(context);
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}