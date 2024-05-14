import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/home/view/doctor_root_tab.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/home/view/root_tab.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/view/doctor_signup_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/view/patient_signup_screen.dart';
import '../../colors.dart';
import '../../home/layout/default_layout.dart';
import '../component/custom_text_form.field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';
  bool isMobile = true;
  final database = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                const SizedBox(height: 16.0),
                const _SubTitle(),
                Image.asset(
                  'asset/img/logo/mainLogo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: '아이디를 입력해주세요.',
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요.',
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      // Patients 테이블에서 아이디와 비밀번호 확인
                      final patient = await database.getPatientByUserIdAndPassword(username, password);
                      if (patient != null) {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RootTab()),
                        );
                      } else {
                        // 로그인 실패, 에러 메시지 표시
                        print("환자 로그인 실패하였습니다.");
                      }
                    } else {
                      // Doctors 테이블에서 아이디와 비밀번호 확인
                      final doctor = await database.getDoctorByUserIdAndPassword(username, password);
                      if (doctor != null) {
                        // 로그인 성공, 다른 화면으로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>DoctorRootTab()),
                        );
                      } else {
                        // 로그인 실패, 에러 메시지 표시
                        print("의사 로그인 실패하였습니다.");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                  ),
                  child: const Text(
                    '로그인',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // 플랫폼 확인
                    if (Platform.isAndroid) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PatientSignupScreen()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DoctorSignupScreen()),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: const Text(
                    '회원가입',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '아이디와 비밀번호를 입력해서 로그인 해주세요!)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}