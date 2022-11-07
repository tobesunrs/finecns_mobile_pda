import 'package:flutter/material.dart';

// const labelTextStyle = TextStyle(
//     fontSize: MediaQuery.of(context).size.width * 0.10,
//     color: Color(0xFFFFFFFF)
// );


class IconContent extends StatelessWidget {

  IconContent({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {

    var labelTextStyle = TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.05,
        color: Color(0xFFFFFFFF)
    );


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          child: Icon(

            icon,
            size: MediaQuery.of(context).size.width * 0.12,
            color: Colors.white,

          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          label,
          style: labelTextStyle,
        )
      ],
    );
  }
}
