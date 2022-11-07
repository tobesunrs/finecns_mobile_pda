import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../components/ip_get.dart';
import '../../components/user_get.dart';



class ScanTest extends StatefulWidget {
  const ScanTest({Key? key}) : super(key: key);

  @override
  _ScanTestState createState() => _ScanTestState();
}

class _ScanTestState extends State<ScanTest> {
  double? _width;
  double? _height;
  String? _ip;
  String? _userCode;
  List<dynamic> dataList=[];
  String? _data;
  String? _message;

  String? _barcode;
  late bool visible;

  final TextEditingController _textController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  final _controller = StreamController<String?>();

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

  final FocusNode _focusNode = FocusNode();

  /*@override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: DefaultTextStyle(
        style: textTheme.bodyText1!,
        child: RawKeyboardListener(
          focusNode: _focusNode,
          onKey: (RawKeyEvent event) {
            print("wow1" + event.toString());
            print("wow2" + event.data.toString());

            final key = event.logicalKey;

            setState(() {

            });

          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _message ?? 'Press a key',
              ),
              Text(
                '${_message?.length}',
              ),
            ],
          ),
        ),
      ),
    );
  }*/
  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('테스트'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InputWithKeyboardControl(
              focusNode: InputWithKeyboardControlFocusNode(),
              controller: textEditingController,
              onSubmitted: (value) {
                //print(value);
                setState(() {

                });
              },
              autofocus: true,
              width: 300,
              startShowKeyboard: false,
              buttonColorEnabled: Colors.blue,
              buttonColorDisabled: Colors.black,
              underlineColor: Colors.black,
              showUnderline: true,
              showButton: true,
            ),
          ],
        ),
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    _width = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('스캐너테스트'),
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.arrowAltCircleLeft),
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
              },
            ),
          ),
          body: BarcodeKeyboardListener(
            bufferDuration: const Duration(milliseconds: 200),
            onBarcodeScanned: (barcode) {
              _barcode = barcode;
            },
            child: Column(
              children: [
                TextFormField(
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
                ),
                TextField(

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  /*@override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('스캐너테스트'),
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowAltCircleLeft),
            onPressed: () {
              Navigator.of(context).pushNamed('/home');
            },
          ),
        ),
        body: VisibilityDetector(
          onVisibilityChanged: (VisibilityInfo info) {
            visible = info.visibleFraction > 0;
          },
          key: Key('visible-detector-key'),
          child: BarcodeKeyboardListener(
            bufferDuration: Duration(milliseconds: 200),
            onBarcodeScanned: (barcode) {
              print(barcode);
              if (!visible) return;
              setState(() {
                _barcode = barcode;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _barcode == null ? 'SCAN BARCODE' : 'BARCODE: $_barcode',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }*/
}