import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/home/view/doctor_root_tab.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/home/view/root_tab.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/model/doctor_info.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/view/doctor_signup_screen.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/login/view/patient_signup_screen.dart';
import '../../colors.dart';
import '../../data.dart';
import '../../home/layout/default_layout.dart';
import '../component/custom_text_form.field.dart';
import 'package:http/http.dart' as http;
import '../model/user_info.dart';

final userInfoProvider = ChangeNotifierProvider((ref) => UserInformation());
final doctorInfoProvider = ChangeNotifierProvider((ref) => DoctorInfo());
final myDatabaseProvider = Provider<MyDatabase>((ref) {
  return MyDatabase();
});

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String? BASE_URL = dotenv.env['BASE_URL'];

  String username = '';
  String password = '';
  bool isMobile = true;

  Future<bool> doctorLogin() async {
    final url = Uri.parse('$BASE_URL/sign-in');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': username, 'pw': password}),
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['result'] == 'success') {
        return true;
      } else {
        print('서버에 정보가 없어 의료진 로그인 실패..');
        return false;
      }
    } else {
      print('서버 오류로 인한 로그인 실패..');
      return false;
    }
  }

  Future<bool> patientLogin() async {
    final url = Uri.parse('$BASE_URL/sign-in');
    print(url);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': username, 'pw': password}),
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['result'] == 'success') {
          return true;
      } else {
        print('서버에 정보가 없어 환자 로그인 실패..');
        return false;
      }
    } else {
      print('서버 오류로 인한 로그인 실패..');
      return false;
    }
  }

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
                      bool patientSuccess = await patientLogin();
                      if(patientSuccess) {
                        if(await GetIt.I<MyDatabase>().isPatientIdExists(username)){
                          final patient = await GetIt.I<MyDatabase>().getPatientByUserIdAndPassword(username, password);
                          if (patient != null) {
                            ref.read(userInfoProvider).setUserId(username);
                            ref.read(userInfoProvider).setUserInfo(patient);

                            if (!GetIt.I.isRegistered<UserInformation>()) {
                              GetIt.I.registerSingleton<UserInformation>(ref.read(userInfoProvider));
                            }
                            print("환자 로그인 성공!");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RootTab()),
                            );
                          }
                        }
                        else{
                          print("디비에 정보가 없어 로그인에 실패하였습니다");
                        }
                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("환자 로그인 실패"),
                              content: Text("아이디와 비밀번호를 확인해주세요."),
                              actions: [
                                TextButton(
                                  child: Text("확인"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                    else if(Platform.isWindows) {
                      bool doctorSuccess = await doctorLogin();
                      if(doctorSuccess) {
                        if(await GetIt.I<MyDatabase>().isDoctorIdExists(username)){
                          final doctor = await GetIt.I<MyDatabase>().getDoctorByUserIdAndPassword(username, password);
                          if (doctor != null) {
                            ref.read(doctorInfoProvider).setDoctorId(username);
                            ref.read(doctorInfoProvider).setDoctorInfo(doctor);

                            if (!GetIt.I.isRegistered<DoctorInfo>()) {
                              GetIt.I.registerSingleton<DoctorInfo>(ref.read(doctorInfoProvider));
                            }

                            print("의료진 로그인 성공!");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorRootTab()),
                            );
                          }
                        }
                        else{
                          print('디비에 정보가 없어 로그인에 실패하였습니다');
                        }
                      }
                      else{
                        ScaffoldMessenger.of(context).showMaterialBanner(
                          MaterialBanner(
                            content: Text("아이디와 비밀번호를 확인해주세요."),
                            leading: Icon(Icons.error, color: Colors.red),
                            backgroundColor: Colors.yellow,
                            actions: <Widget>[
                              TextButton(
                                child: Text("확인"),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("로그인 실패"),
                            content: Text("로그인에 실패하였습니다. 아이디와 비밀번호를 확인해주세요."),
                            actions: [
                              TextButton(
                                child: Text("확인"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
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
                        MaterialPageRoute(
                            builder: (context) => PatientSignupScreen()),
                      );
                    } else if(Platform.isWindows) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorSignupScreen()),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
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