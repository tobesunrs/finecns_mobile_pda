import 'dart:convert';

import 'package:finecns_mobile_pda/components/userName_get.dart';
import 'package:finecns_mobile_pda/components/version_get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../components/alert_yes_no.dart';
import '../../components/icon_content.dart';
import '../../components/ip_get.dart';
import '../../components/reusable_card.dart';
import '../../components/user_get.dart';
import 'package:http/http.dart' as http;

import '../setting/setting.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _version="";
  String _ip="";
  String? _userCode;
  String _userName="";
  List<dynamic> dataList = [];
  List<dynamic> versionList = [];
  double? _width;
  double? _height;
  final AlertYesNo ayn = new AlertYesNo();

  @override
  void initState() {
    ipGet().then((value) => {
      _ip = value,
      userGet().then((value) => {
        _userCode = value,
        menuListMake(),
        versionGet().then((value) => {
          _version = value,
          userNameGet().then((value) => {
            _userName = value,
          }),
        }),

      })
    });

    super.initState();
  }

  menuListMake() async{
    setState(() {
      dataList.add({
        "menu_code": "scmIn",
        "menu_name": "자재입고",
      });
      dataList.add({
        "menu_code": "scmOut",
        "menu_name": "자재출고",
      });
      dataList.add({
        "menu_code": "scmMove",
        "menu_name": "자재이동",
      });
      dataList.add({
        "menu_code": "wmsIn",
        "menu_name": "생산실적등록",
      });
      dataList.add({
        "menu_code": "wmsQms",
        "menu_name": "제품검사",
      });
      dataList.add({
        "menu_code": "wmsOut",
        "menu_name": "제품출고",
      });
      dataList.add({
        "menu_code": "wmsMove",
        "menu_name": "제품이동",
      });
      dataList.add({
        "menu_code": "wmsRetIn",
        "menu_name": "제품반입",
      });
      dataList.add({
        "menu_code": "wmsRetOut",
        "menu_name": "반출/폐기",
      });
      dataList.add({
        "menu_code": "scmStockSet",
        "menu_name": "자재재고 실사",
      });
      dataList.add({
        "menu_code": "wmsStockSet",
        "menu_name": "제품재고 실사",
      });
      dataList.add({
        "menu_code": "setting",
        "menu_name": "설정",
      });
    });
    /*try {
      final response = await http.post(
        Uri.parse('$_ip/menuListGet'),
        body: jsonEncode(
          {
            'keyword': _userCode,
          },
        ),
        headers: {'Content-Type': "application/json"},
      );

      var responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> _list1 = jsonDecode(responseBody);


      setState(() {
        dataList = [];
        dataList = _list1;
        dataList.add({
          "menu_code": "setting",
          "menu_name": "설정"
        });
      });
    } catch(e) {
      setState(() {
        dataList = [];
        dataList.add({
          "menu_code": "setting",
          "menu_name": "설정"
        });
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        outButtonsPressed(
            context, AlertType.info, '프로그램을 종료하시겠습니까?', '확인', '취소');
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('메뉴화면', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/home');
                },
                icon: Icon(FontAwesomeIcons.redoAlt))
          ],
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: GridView.builder(
              itemCount: dataList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index){
                if(dataList.length == 0){
                  return Container(
                      height: 20,
                      width: 20,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 200),
                              alignment: Alignment.center,
                              color: Colors.red,
                              child: Text("권한된 메뉴가 없습니다.",style: TextStyle(fontSize: 15))
                          )
                      )
                  );
                }
                else{
                  return GestureDetector(
                    child: ReusableCard(
                      color: Color(0xFF757575),
                      cardChild: IconContent(
                        //icon: FontAwesomeIcons.calendarCheck,
                        icon: iconCheck(context, dataList[index]["menu_name"]),
                        label: dataList[index]["menu_name"],
                        //label: test(dataList[index]["menu_name"], index),

                      ),
                    ),
                    onTap: () async {
                      moveCheck(context,dataList[index]["menu_name"]);
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  // 아이콘 설정
  iconCheck(BuildContext context, String value){
    if(value == "자재입고"){
      return FontAwesomeIcons.calendarCheck;
    }
    else if(value == "자재출고"){
      return FontAwesomeIcons.boxOpen;
    }
    else if(value == "자재이동"){
      return FontAwesomeIcons.peopleCarryBox;
    }
    else if(value == "생산실적등록"){
      return FontAwesomeIcons.boxesPacking;
    }
    else if(value == "제품검사"){
      return FontAwesomeIcons.fileCircleCheck;
    }
    else if(value == "제품출고"){
      return FontAwesomeIcons.truckLoading;
    }
    else if(value == "제품이동"){
      return FontAwesomeIcons.cartFlatbed;
    }
    else if(value == "제품반입"){
      return FontAwesomeIcons.dolly;
    }
    else if(value == "반출/폐기"){
      return FontAwesomeIcons.trashCan;
    }
    else if(value == "자재재고 실사"){
      return FontAwesomeIcons.listCheck;
    }
    else if(value == "제품재고 실사"){
      return FontAwesomeIcons.listCheck;
    }
    else if(value == "설정"){
      return FontAwesomeIcons.tools;
    }
  }
  moveCheck(BuildContext context, String value) async {
    if(value == "자재입고"){
      Navigator.of(context).pushNamed('/scmIn');
    }
    else if(value == "설정"){
      //Navigator.of(context).pushNamed('/setting');
      Navigator.pushNamed(context,'/setting',arguments: SettingArgument(_userName, _ip, _version));
    }
    else{
      ayn.onAlertButton(context, AlertType.info, "업데이트 준비중입니다.", '확인', () =>  Navigator.of(context).pop());
    }
  }
  // 프로그램 종료 알림창
  outButtonsPressed(BuildContext context, type, title, text1, text2) async {
    var result = await Alert(
      alertAnimation: fadeAlertAnimation,
      context: context,
      type: type,
      title: title,
      buttons: [
        DialogButton(
          child: Text(
            text1,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context, true),

          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0),
          ]),
        ),
        DialogButton(
          child: Text(
            text2,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context, false),
          color: Color.fromRGBO(158, 29, 90, 1.0),
        )
      ],
    ).show();
    if (result == true) {
      SystemNavigator.pop();
    }
  }
}

Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    ) {
  return Align(
    child: FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
