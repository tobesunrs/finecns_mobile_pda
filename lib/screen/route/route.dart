import 'package:finecns_mobile_pda/screen/home/home.dart';
import 'package:finecns_mobile_pda/screen/keyPage/keyPage.dart';
import 'package:finecns_mobile_pda/screen/login/login.dart';
import 'package:finecns_mobile_pda/screen/scmIn/scmIn.dart';

import '../scanTest/scanTest.dart';
import '../setting/setting.dart';

final routes = {
  '/keyPage' : (context) => KeyPage(title: '',),        // 인증코드
  '/login' : (context) => Login(title: '',),        // 로그인
  '/test' : (context) => ScanTest(),        // 테스트
  '/home' : (context) => Home(),        // 메뉴화면
  '/setting' : (context) => SettingPage(),        // 설정화면
  '/scmIn' : (context) => ScmIn(),        // 자재입고
};