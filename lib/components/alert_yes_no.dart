import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertYesNo {


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

  onAlertButtonsPressed(context,type,title,text1,text2,onPress) {
    Alert(
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
          onPressed: onPress,
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
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(158, 29, 90, 1.0),
        )
      ],
    ).show();
  }

  onAlertButton(context,type,title,text1,onPressed) {
    Alert(
      alertAnimation: fadeAlertAnimation,
      context: context,
      // type: AlertType.error,
      type: type,
      title: title,
      // desc: text1,
      buttons: [
        DialogButton(
          child: Text(
            text1,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: onPressed,
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0),
          ]),
          // onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

}
