import 'package:flutter/material.dart';
import 'package:festivia/utils/colors.dart' as utils;

class ButtonApp extends StatelessWidget {
  Color color;
  Color textColor;
  String text;
  IconData icon;
  Function onPressed;

  ButtonApp(
      {this.color = Colors.black,
      this.textColor = Colors.white,
      this.icon = Icons.arrow_forward_ios,
      this.onPressed,
      this.text});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        onPressed();
      },
      color: color,
      textColor: textColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Ubuntu",
                  ),
                )),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 50,
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
