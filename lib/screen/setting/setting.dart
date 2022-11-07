import 'package:finecns_mobile_pda/components/userName_get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/ip_get.dart';
import '../../components/user_get.dart';
import '../../components/version_get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class SettingArgument{
  final String userName;
  final String ip;
  final String version;

  SettingArgument(this.userName, this.ip, this.version);
}

class _SettingPageState extends State<SettingPage> {

  double _width = 0.0;
  double _height = 0.0;
  String? userName;
  String? userCode;
  String? ip;
  String? version;

  SharedPreferences? _prefs;

  @override
  void initState() {
    ipGet().then((value) => {
      ip = value,
      userGet().then((value) => {
        userCode = value,
        versionGet().then((value) => {
          version = value,
        }),
      })
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SettingArgument items = ModalRoute.of(context)!.settings.arguments as SettingArgument;
    userName = items.userName;
    ip = items.ip;
    version = items.version;

    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              '앱 설정',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.arrowAltCircleLeft),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width : 0.9 * _width,
                            height: 0.8 * _height,
                            child: Column(
                              children: <Widget>[
                                textHeader("내 계정정보"),
                                SizedBox(height: 10),
                                userArea(),
                                companyArea(),
                                projectArea(),
                                SizedBox(height: 30),
                                textHeader("도메인 정보"),
                                SizedBox(height: 10),
                                ipArea(),
                                SizedBox(height: 30),
                                textHeader("프로그램 정보"),
                                SizedBox(height: 10),
                                programArea(),
                                SizedBox(height: 30),
                              ],
                            ),

                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

  textHeader(String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
      child: Row(
        children: <Widget>[
          Icon(FontAwesomeIcons.checkCircle),
          Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
          Text(value)
        ],
      ),
    );
  }

  textArea(textName, index){
    if(index == '1'){
      return Align(
        child: Container(
            alignment: Alignment.centerLeft,
            color: Colors.grey[100],
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: txtStyle_12(textName)
            )
        ),
      );
    }else{
      return Align(
        child: Container(
            alignment: Alignment.centerRight,
            color: Colors.grey[100],
            child: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: txtStyle_12(textName)
            )
        ),
      );
    }

  }
  // 오른쪽 내부 텍스트(값)
  valueArea(valueType){
    if(valueType == '1'){
      return Container(
        color: Colors.grey[100],
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //Text(_userName, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF00467F)),),
              Text(userName.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF00467F)),),
              Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0),),
              Icon(FontAwesomeIcons.arrowRight, color: Color(0xFF00467F),),
            ],
          ),
          onPressed: (){
            _ynDialog('로그아웃합니다.', userName.toString());
          },
        ),
      );
    }
    else if(valueType == '2'){
      return Container(
          alignment: Alignment.centerRight,
          color: Colors.grey[100],
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Text('(주)화인씨앤에스', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF00467F)),),
          )
      );
    }
    else if(valueType == '3'){
      return Container(
          alignment: Alignment.centerRight,
          color: Colors.grey[100],
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Text('MES 시스템', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF00467F)),),
          )
      );
    }
  }

  userArea() {
    return Align(
      child: Container(
        //alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            border: Border.all(
              color: (Colors.grey[300])!,
            ),
            borderRadius: BorderRadius.circular(3)
        ),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        //padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: Container(
          //padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          height: 40.0,
          width: _width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(child: textArea('계정정보', '1')),
              Flexible(child: valueArea('1')),
            ],
          ),
        ),
      ),
    );
  }
  // 회사정보
  companyArea() {
    return Align(
      child: Container(
        //alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            border: Border.all(
              color: (Colors.grey[300])!,
            ),
            borderRadius: BorderRadius.circular(3)
        ),
        //padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: Container(
          //padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          height: 40.0,
          width: _width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(child: textArea('회사정보', '1')),
              Flexible(child: valueArea('2')),
            ],
          ),
        ),
      ),
    );
  }
  projectArea() {
    return Align(
      child: Container(
        //alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            border: Border.all(
              color: (Colors.grey[300])!,
            ),
            borderRadius: BorderRadius.circular(3)
        ),
        //padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: Container(
          //padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          height: 40.0,
          width: _width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(child: textArea('프로젝트명', '1')),
              Flexible(child: valueArea('3')),
            ],
          ),
        ),
      ),
    );
  }

  ipArea(){
    return Container(
      height: 40.0,
      width: _width * 0.9,
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(3)
      ),
      child: Center(
        child: Text(
          ip == null ? "등록된 IP가 없습니다." : ip.toString(),
          style: TextStyle(
              fontSize: 18, color: Color(0xFF616161)
          ),
        ),
      ),
    );
  }

  programArea(){
    return Container(
      height: 40.0,
      width: _width * 0.9,
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(3)
      ),
      child: OutlinedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ver ' + version.toString(),
                style: TextStyle(fontSize: 18, color: Color(0xFF616161)),
              ),
              Icon(FontAwesomeIcons.arrowRight, color: Color(0xFF616161),)
            ],
          ),
          onPressed: (){
            _showDialog('MES 시스템', '현재버전 : '+'Ver ' + version.toString());
          }
      ),
    );
  }

  void _showDialog(String titleText, String versionText) {
    showDialog(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(titleText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
          content: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
                  Text(versionText),
                  Padding(padding: EdgeInsets.fromLTRB(0, 70, 0, 0)),
                  Text('ⓒ TOBESYSTEM Corp.'),
                ],
              )
          ),
          actions: <Widget>[
            Center(
              child: new OutlinedButton(
                child: new Text("닫기"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _ynDialog(String titleText, String infoText) {
    showDialog(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Center(child: Text(titleText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
          content: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
                  Text(titleText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
                  Row(
                    children: [
                      Text(infoText, style: TextStyle(color: Color(0xFF00467F)),),
                      Text(' 아이디가 로그아웃 됩니다.'),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                  Text('계속 진행하시겠습니까?'),
                ],
              )
          ),
          actions: <Widget>[
            Center(
              child: Column(
                children: [
                  Container(
                    width: 200,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        FontAwesomeIcons.checkCircle,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF00467F)
                      ),
                      label: Text("확인",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      onPressed: () {
                        _prefs?.remove('login');
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                  Container(
                    width: 200,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        FontAwesomeIcons.timesCircle,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF00467F)
                      ),
                      label: Text("취소",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

txtStyle_12(String content) {
  return Text(
    content,
    // textAlign: TextAlign.center,
    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
  );
}

txtStyle_13(String content) {
  return Text(
    content,
    // textAlign: TextAlign.center,
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );
}