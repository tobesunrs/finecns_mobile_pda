 import 'package:finecns_mobile_pda/ui/widget/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class KeyPage extends StatefulWidget {
  KeyPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _KeyPageState createState() => _KeyPageState();
}

class _KeyPageState extends State<KeyPage> {

  late TextEditingController passController;

  String loginText = "";

  //static final storage = new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업

  @override
  void initState() {
    // 세로 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
    passController = TextEditingController();
  }



  @override
  Widget build(BuildContext context) {
    //ScreenUtil.instance.init(context);
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: UIHelper.WHITE,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ProgressHUD(
        backgroundColor: Colors.red,
        child: Builder(
          builder:(context) => SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
                  child: Image.asset("assets/logo/logo.png"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                  child: Column(
                    children: <Widget>[
                      _textField(
                          "인증키를 입력하세요.",
                          true,
                          Icon(Icons.vpn_key,
                              color: Color(0xFF1AB7EA)),passController),
                      _loginButton(context),
                      Text(loginText,style: TextStyle(color:Colors.red),),
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

  Widget _loginButton(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: MaterialButton(
      height: 56,
      minWidth: double.infinity,
      color: Color(0xFF00467F),
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30)),
      onPressed: () async {

        final progress = ProgressHUD.of(context);
        progress?.showWithText('Loading...');
        Future.delayed(Duration(seconds: 1), () {
          progress?.dismiss();

          _authKeyCheck(passController.text.toString()).then((data) async {
            dynamic logInfo = data;
            if(logInfo == "ok"){
              //print(logInfo);
              Navigator.of(context).pushNamedAndRemoveUntil('/login',(Route<dynamic> route) => false);
            }
          });
        });
      },
      child: Text(
        "KEY LOGIN",
        style: TextStyle(
            fontSize: UIHelper.dynamicSp(30),
            color: UIHelper.WHITE,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5),
      ),
    ),
  );

  Future<dynamic> _authKeyCheck(String password) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    return new Future<dynamic>(() async {

      dynamic parsedResponse;

      if(passController.text.toString() == "FINE-MES"){
        //_prefs.setString("authKey", passController.text.toString());
        parsedResponse = "ok";
      }
      else{
        setState(() {
          loginText = "인증키를 확인 해주세요";
        });
        parsedResponse = "ng";
      }

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