import 'dart:convert';

import 'package:finecns_mobile_pda/ui/widget/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  Login({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  TextEditingController idController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController _pathText = new TextEditingController();
  SharedPreferences? _prefs;

  String loginText = "";
  String _UserName='';
  String _Ip = "";

  @override
  void initState() {
    super.initState();
    loadCache();
  }

  loadCache()async{
    _prefs = await SharedPreferences.getInstance();

    setState(() {
      _Ip = _prefs?.getString('ip') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: UIHelper.WHITE,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ProgressHUD(
          backgroundColor: Colors.red,
          child: Builder(
            builder:(context) => SingleChildScrollView(
              child:
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 100, 100, 0),
                    child: Image.asset("assets/logo/logo.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                    child: Column(
                      children: <Widget>[
                        _textField(UIHelper.email, false,
                            Icon(Icons.email, color: Color(0xFF1AB7EA)),idController),
                        _textField(
                            UIHelper.password,
                            true,
                            Icon(Icons.vpn_key,
                                color: Color(0xFF1AB7EA)),passController),
                        _loginButton(context),
                        Text(loginText,style: TextStyle(color:Colors.red),),
                        _settingButton(context),
                        _delStorageButton(context),
                      ],
                    ),
                  ),
                ],
              ),

            ),
          ),
        ),
      ),

    );
  }

  Widget _textField(String text, bool obscure, Icon icon,TextEditingController tdc) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
    child: TextField(
      controller: tdc,
      style: TextStyle(color: UIHelper.CHERRY_INPUT_TEXT_COLOR),
      textAlign: TextAlign.left,
      obscureText: obscure,
      autocorrect: false,
      cursorColor: UIHelper.POMEGRANATE_TEXT_COLOR,
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: text,
        hintStyle: TextStyle(color: UIHelper.BLACK),
      ),
    ),
  );

  Widget _settingButton(BuildContext context) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: RawMaterialButton(
        onPressed: () {
          _settingArea();
        },
        elevation: 2.0,
        //fillColor: Colors.white,
        child: Icon(
          FontAwesomeIcons.cog,
          size: 40.0,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      )
  );

  Widget _delStorageButton(BuildContext context) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: RawMaterialButton(
        onPressed: () {
          _prefs?.remove('authKey');
          _prefs?.remove('ip');
        },
        elevation: 2.0,
        child: Icon(
          FontAwesomeIcons.trashAlt,
          size: 40.0,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      )
  );
  // 시스템경로 변경
  changeIp(String value)async{
    if(value != ''){
      _prefs?.remove('ip');
      setState(() {
        _prefs?.setString('ip', value);
      });
      _Ip = value;
    }
  }
  _settingArea(){
    if(_Ip == null || _Ip.length == 0){
      _Ip = "http://192.168.3.6:8282/";
    }
    showDialog(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Center(child: Text(titleText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
          content: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                  Text("설정정보", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                  //Text(_Ip.replaceAll('http://', '')),
                  Row(
                    children: [
                      Container(
                          child: Text(
                              'http://',
                              style: TextStyle(fontSize: 18)
                          )
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                      Expanded(
                        child: Container(
                          child: TextField(
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: 'asdas',
                              //hintText: 'mes.dayou.co.kr',
                              //hintText: _Ip.replaceAll('http://', ''),
                              hintText: "경로를 입력해주세요.",
                            ),
                            controller: _pathText,
                            maxLines: 1,
                            onChanged: (text){
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

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
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF00467F))
                      ),
                      label: Text("적용",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      onPressed: () {
                        //print("http://"+_pathText.text);
                        changeIp("http://"+_pathText.text+"/");
                        Navigator.pop(context);
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
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF00467F))
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

  Widget _loginButton(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: MaterialButton(
      height: 56 ,
      minWidth: double.infinity,
      color: Color(0xFF00467F),
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30)),
      onPressed: () async {

        if(idController.text.toString() == "devel" && passController.text.toString() == "devel"){

          setState(() {
            _prefs?.setString('user_name', idController.text.toString());

            _prefs?.setString('user_code', idController.text.toString());

            _prefs?.setString('ip', _Ip);

          });

          Navigator.pop(context);
          Navigator.of(context).pushNamed('/home');
        }
        else{
          setState(() {
            loginText = "아이디와 비밀번호를 확인 해주세요";
          });
        }
        /*final progress = ProgressHUD.of(context);
        progress?.showWithText('Loading...');
        Future.delayed(Duration(seconds: 1), () {
          progress?.dismiss();

          _loginCheck(idController.text.toString(),passController.text.toString()).then((data) async {
            dynamic logInfo = data;
            if(logInfo['result'] == 'OK') {

              print(logInfo);

              setState(() {
                _prefs?.setString('login', idController.text.toString());

                _prefs?.setString('user_code', logInfo['user_code']);

                _prefs?.setString('ip', _Ip);

              });

              Navigator.pop(context);
              Navigator.of(context).pushNamed('/home');
            } else {
              setState(() {
                loginText = "아이디와 비밀번호를 확인 해주세요";
              });
              print('err');
            }
          });
        });*/
      },
      child: Text(
        UIHelper.login.toUpperCase(),
        style: TextStyle(
            fontSize: UIHelper.dynamicSp(30),
            color: UIHelper.WHITE,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5),
      ),
    ),
  );

  Future<dynamic> _loginCheck(String id,String password) async {

    return new Future<dynamic>(() async {

      final response = await http.post(
        Uri.parse(_Ip + '/login'),
        body: jsonEncode(
          {
            'user_code': id,
            'user_pwd': password,
          },
        ),
        headers: {'Content-Type': "application/json"},
      );

      var responseBody = utf8.decode(response.bodyBytes);
      final dynamic parsedResponse = jsonDecode(responseBody);

      return parsedResponse;
    }
    );
  }

}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()..color = UIHelper.CHERRY_PRIMARY_COLOR;
    // create a path
    var path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.300,
        size.width * 0.5, size.height * 0.760);
    path.quadraticBezierTo(size.width * 0.75, size.height * 1.3, size.width * 1,
        size.height * 0.940);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;


}