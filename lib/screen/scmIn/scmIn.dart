import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/ip_get.dart';
import '../../components/user_get.dart';

class ScmIn extends StatefulWidget {
  const ScmIn({Key? key}) : super(key: key);

  @override
  _ScmInState createState() => _ScmInState();
}

class _ScmInState extends State<ScmIn> {
  double _width = 0.0;
  double _height = 0.0;
  String _ip = "";
  String _userCode = "";
  String _msg = "";
  String _trNo = "";
  String _itemCode = "";
  String _inQty = "";
  String _okQty = "";
  String _ngQty = "";
  String _freeQty = "";
  String _asQty = "";
  String _elseQty = "";
  String _barcode = "";
  bool _itemCode_Check = false;

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    ipGet().then((value) => {
      _ip = value,
      userGet().then((value) => {
        _userCode = value,
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            '자재입고',
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
        body: BarcodeKeyboardListener(
          bufferDuration: const Duration(milliseconds: 200),
          onBarcodeScanned: (barcode) {
            _barcode = barcode;
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  children: <Widget>[
                    /*TextFormField(
                      focusNode: _focusNode,
                      controller: _textController,
                      keyboardType: TextInputType.none,
                      decoration: const InputDecoration(
                        hintText: "Barcode",
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.person_pin,
                          size: 30,
                        ),
                      ),
                      onChanged: (value) {
                        print(value);
                      },
                      onFieldSubmitted: (text) async {
                        //print(text);
                        setState(() {
                          _textController.clear();
                          _barcode = "";
                        });
                      },
                      textInputAction: TextInputAction.done,
                      autofocus: true,
                    ),*/
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          //rowMakeList("최상단", "거래명세서", _trNo, context),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF000000)),),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Container(alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(color: Color(0xFF000000)),
                                            )
                                        ),
                                        height: 50,
                                        child: txtStyle_12("거래명세서"),),
                                    )),
                                Expanded(
                                    flex: 5,
                                    child: Container(alignment: Alignment.center,
                                      height: 50,
                                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: TextFormField(
                                        focusNode: _focusNode,
                                        controller: _textController,
                                        keyboardType: TextInputType.none,
                                        decoration: const InputDecoration(
                                          hintText: "",
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          print(value);
                                          setState(() {
                                            _trNo = value.toString();
                                            //_itemCode = value.toString();
                                          });
                                          /*if(value.length > 0){
                                            setState(() {
                                              _textController.clear();
                                              _barcode = "";
                                            });
                                          }*/
                                        },
                                        onFieldSubmitted: (text) async {
                                          //print(text);
                                          setState(() {
                                            _textController.clear();
                                            _barcode = "";
                                          });
                                        },
                                        textInputAction: TextInputAction.done,
                                        autofocus: true,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          rowMakeList("메시지", "", _msg, context),
                          rowMakeList("표시", "ITEM CODE", _itemCode, context),
                          rowMakeList("표시", "입고수량", _inQty, context),
                          rowMakeList("표시", "정상입고", _okQty, context),
                          rowMakeList("등록", "불량입고", _ngQty, context),
                          rowMakeList("등록", "무상입고", _freeQty, context),
                          rowMakeList("등록", "A/S입고", _asQty, context),
                          rowMakeList("등록", "기타입고", _elseQty, context),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              rowMakeButton(context, "저장"),
                              rowMakeButton(context, "취소"),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  rowMakeList(String type, String title, String value, BuildContext context){
    if(type == "최상단"){
      return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF000000)),),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Center(
                  child: Container(alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Color(0xFF000000)),
                      )
                    ),
                    height: 50,
                    child: txtStyle_12(title),),
                )),
            Expanded(
                flex: 5,
                child: Container(alignment: Alignment.center,
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: txtStyle_13(value),
                )
            ),
          ],
        ),
      );
    }
    else if(type == "표시"){
      return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFF000000)),
              right: BorderSide(color: Color(0xFF000000)),
              bottom: BorderSide(color: Color(0xFF000000)),
            )
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Center(
                  child: Container(alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Color(0xFF000000)),
                        )
                    ),
                    height: 50,
                    child: txtStyle_12(title),),
                )),
            Expanded(
                flex: 5,
                child: Container(alignment: Alignment.center,
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: txtStyle_13(value),
                )
            ),
          ],
        ),
      );
    }
    else if( type == "메시지"){
      return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFF000000)),
              right: BorderSide(color: Color(0xFF000000)),
              bottom: BorderSide(color: Color(0xFF000000)),
            )
        ),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 50,
              child: txtStyle_13(value),
            )
          ],
        ),
      );
    }
    else if(type == "등록"){
      if(title != "불량입고"){
        return Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFF000000)),
                right: BorderSide(color: Color(0xFF000000)),
                bottom: BorderSide(color: Color(0xFF000000)),
              )
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Center(
                    child: Container(alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Color(0xFF000000)),
                          )
                      ),
                      height: 50,
                      child: txtStyle_12(title),),
                  )),
              Expanded(
                  flex: 5,
                  child: Container(alignment: Alignment.center,
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: txtStyle_13(value),
                  )
              ),
            ],
          ),
        );
      }
      // 불량입고일때,
      else{
        if(_itemCode_Check == false){
          return Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Color(0xFF000000)),
                  right: BorderSide(color: Color(0xFF000000)),
                  bottom: BorderSide(color: Color(0xFF000000)),
                )
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Center(
                      child: Container(alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Color(0xFF000000)),
                            )
                        ),
                        height: 50,
                        child: txtStyle_12(title),),
                    )),
                Expanded(
                    flex: 5,
                    child: Container(alignment: Alignment.center,
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: txtStyle_13(value),
                    )
                ),
              ],
            ),
          );
        }
        else{
          return Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Color(0xFF000000)),
                  right: BorderSide(color: Color(0xFF000000)),
                  bottom: BorderSide(color: Color(0xFF000000)),
                )
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Center(
                      child: Container(alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Color(0xFF000000)),
                            )
                        ),
                        height: 50,
                        child: txtStyle_12(title),),
                    )),
                Expanded(
                    flex: 5,
                    child: Container(alignment: Alignment.center,
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: txtStyle_13(value),
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Container(alignment: Alignment.center,
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: txtStyle_13(value),
                    )
                ),
              ],
            ),
          );
        }
      }
    }
  }
  // 버튼생성
  rowMakeButton(BuildContext context, String title){
    if(title == "저장"){
      return GestureDetector(
        onTap: (){
          print("저장");
        },
        child: Container(
          width: 100,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
                color: Colors.indigo),
            borderRadius:
            BorderRadius.circular(5),
          ),
          child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25),
              )),
        ),
      );
    }
    else{
      return GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Container(
          width: 100,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
                color: Colors.indigo),
            borderRadius:
            BorderRadius.circular(5),
          ),
          child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25),
              )),
        ),
      );
    }
  }
}

txtStyle_12(String content) {
  return Text(
    content,
    style: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00467F)),
  );
}

txtStyle_13(String content) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
    child: Text(
      content,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}