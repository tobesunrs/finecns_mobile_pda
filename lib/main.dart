import 'package:finecns_mobile_pda/screen/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MainApp myApp;

  // 캐시에 저장되어있는 값을 불러온다.
  SharedPreferences _prefs = await SharedPreferences.getInstance();

  if(_prefs.getString("authKey") != null){
    if(_prefs.getString("login") != null){
      myApp = MainApp(initialRoute: '/home');
    }
    else{
      myApp = MainApp(initialRoute: '/login');
    }
  }
  else{
    myApp = MainApp(initialRoute: '/keyPage');
  }

  if(_prefs.getString("ip") == null || _prefs.getString("ip") == ''){
    _prefs.setString("ip", "http://192.168.3.6:8282/");
  }

  runApp(myApp);
}
class MainApp extends StatelessWidget{

  MainApp({Key? key, required this.initialRoute}) : super(key: key);
  final String initialRoute;

  @override
  Widget build(BuildContext context){

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ko', 'KO'),
      ],
      debugShowCheckedModeBanner: false,
      title: '화인씨엔에스 MES.',
      initialRoute: initialRoute,
      theme: new ThemeData(

          fontFamily: 'NanumGothic'
      ),
      routes : routes,
    );
  }
}
