# 거동 불편한 환자 위한 블록체인 검증 의료 앱
### 2024 과학기술정보통신부 ICT멘토링 프로보노 프로젝트
- 블록체인을 통한 의료 데이터 저장 및 무결성 검증
- 의료 데이터를 본인 기기에 저장하여 자신이 관리
- Flutter를 통해 환자는 모바일 앱, 의료진은 데스크톱 앱 
- 모바일 프론트엔드2, 백엔드2, LG U+멘토님1, 교수님1으로 구성

## 1. 문제 정의
#### 1) 병원 이동 시, 환자의 효율적인 데이터 제공 필요성
  - 현재 의료 체계에서 환자가 병원 이동 시, 환자의 데이터를 다시 제공
  - 응급 상황에서 환자의 치료 이력과 건강 특이 상황을 신속하게 파악하는 것이 중요
#### 2) 구두로 진행되어 일관적이지 않고 부정확한 진료 상담
  - 환자는 증상 설명 시, 환자는 잘못된 기억에 의존하여 사실이 아닌 설명 가능
  - 환자마다 증상 표현 방법이 달라 일관적으로 환자 상태 파악하기 어려움
  - 의료진은 이러한 이유로 환자의 상태를 정확히 파악하는데 어려움. 이로 인한 오진 가능성 존재
#### 3) 의료 데이터 접근성 낮음
  - 일반인들은 의료 데이터 접근성이 낮아 의료 지식을 갖추기 어려움 
  - 환자 본인의 의료 데이터 기록(본인의 병이나, 처방 기록, 수술 이력 등) 을 하나의 시스템으로 손쉽게 조회하기 어려움
#### (1)환자 데이터를 의료진에게 손쉽게 공유하고, (2)환자가 본인의 의료 데이터를 손쉽게 조회 및 기록하며, (3)의료 커뮤니티를 통해 의료 데이터 접근성을 높이는 시스템 필요

## 2. 목표
#### 1) 환자
 - 블록체인을 통해 검증된 자신의 의료 데이터 조회
 - 자신의 의료 데이터를 본인의 기기에 저장
 - 자신의 의료 데이터에서 필요 내용 추가 기록
 - 필요한 의료진들에게 자신의 의료 데이터 공유
 - 알림을 통한 효과적인 약물 복용 관리
 - 게시판에서 의료진으로부터 질문 답변
#### 2) 의료진
 - 진료 전 혹은 긴급 상황 시 환자의 의료 데이터 조회
 - 환자의 의료 정보들을 본인의 데스크톱에 저장
 - 블록체인을 통해 자신이 환자에게 제공하는 의료 데이터 무결성 보장
 - 게시판에서 의료진으로서 답변

## 3. 시스템 구조
![image](https://github.com/junghyunsoo24/portfolio-teenager-emotion-prevent-app-teenagers/assets/117528532/07d85dc9-4d0d-40ae-b013-8534f7c4afc7)

## 4. 맡은 역할 및 사용 기술
### Flutter를 통한 크로스플랫폼 App 개발(Android 앱, Window 앱)
#### 1) 역할
- SQLite통한 개인정보/의료 데이터 앱 내 DB 관리
- CODEF 의료 API 통한 카카오 지갑 인증 및 환자의 건강검진/진료내역/처방내역 조회
- FireBase FireStore를 통한 다른 플랫폼 간 데이터 송수신 및 조회/알림
- FireBase FCM을 통한 복용 시간 알림 설정
- 의료 데이터를 해시값으로 변환하여 블록체인에 저장 및 데이터 무결성 검증
#### 2) 기술
- drift통한 SQLite DB 내 ORM 적용
- Future/async/awit 통한 비동기 프로그래밍
- Provider 통한 MVVM 패턴
- 협업 통한 Spring 서버와 RESTful API 통신

## 5. 깨달음
 - 앱 개발을 팀원과 같이 하니 혼자에 비해 직접적인 깃허브 사용 능력과 코드 개선에 도움 
 - 외부 API(CODEF)는 계속 바뀌므로 여기에 너무 의존 X
 - 플러터는 웹/앱을 모두 다루기 때문에 크기에 따라 다르게 개발하는 것 필요

## 6. 성과
- 2024 과학기술정보통신부 ICT멘토링 프로보노 프로젝트 완료
- 2025년 2월 플레이스토어 출시 예정

## 7. UI 화면
### 1) 메인페이지
![스크린샷 2024-07-03 175842](https://github.com/junghyunsoo24/portfolio-teenager-emotion-prevent-app-teenagers/assets/117528532/81362a24-ed9c-463a-8865-52818c184f7c)
### 2) 환자->의료진 의료 데이터 전송
![스크린샷 2024-07-03 182709](https://github.com/junghyunsoo24/portfolio-teenager-emotion-prevent-app-teenagers/assets/117528532/b8d579f0-4d32-4ba6-97d8-10d4abaf93b8)
### 3) 의료진->환자 의료 데이터 전송
![image](https://github.com/junghyunsoo24/portfolio-teenager-emotion-prevent-app-teenagers/assets/117528532/534bfab3-7c03-4d53-8cea-9b8d1937643f)
### 4) 의료진의 환자로부터 받은 전송 이력
![image](https://github.com/junghyunsoo24/portfolio-teenager-emotion-prevent-app-teenagers/assets/117528532/23927bd4-331e-4f4d-97b0-786083dcfa39)
### 5) 환자의 의료 게시판 이용
![image](https://github.com/junghyunsoo24/portfolio-teenager-emotion-prevent-app-teenagers/assets/117528532/7647a3b6-0372-48d8-bbfd-a889c4cd80e2)
### 6) 의료진의 의료 게시판 이용
![image](https://github.com/junghyunsoo24/portfolio-teenager-emotion-prevent-app-teenagers/assets/117528532/d7cff2a3-2ff1-467d-a64a-bd30d16ff7d4)
### 7) 환자의 진료 전 추가 의료 데이터 등록
![image](https://github.com/junghyunsoo24/portfolio-teenager-emotion-prevent-app-teenagers/assets/117528532/6c7b8beb-2c1a-42f2-8fdc-6a1691e21900)
### 8) 환자의 의료 API 불러오기
![image](https://github.com/junghyunsoo24/portfolio-teenager-emotion-prevent-app-teenagers/assets/117528532/644ca5ea-4816-4692-9847-779d65d40b6b)
### 9) 의료데이터 무결성 검증
![image](https://github.com/junghyunsoo24/portfolio_flutter_blockchain_medical_web_app/assets/117528532/21249674-caea-4b56-9a0d-afd2f55e25c0)
