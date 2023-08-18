// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './button.dart';

const greenColor = Color(0xFF26EBC8);
const redColor = Color(0xFFFF6363);

class Keyboard extends StatelessWidget {
  final btnTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );

  Widget buildMathSymbol(IconData data) => FaIcon(data, size: 30.0, color: redColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 16.0,
        top: 32.0,
        left: 16.0,
        right: 16.0,
      ),
      decoration: BoxDecoration(
        color: new Color(0xFF292D36),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.0),
          topRight: Radius.circular(28.0),
        ),
      ),
      child: Column(
        children: [
          Row(children: [
            KeyboardButton(
              child: Text(
                "AC",
                style: btnTextStyle.copyWith(color: greenColor),
              ),
            ),
            KeyboardButton(
              child: Text(
                "+/-",
                style: btnTextStyle.copyWith(color: greenColor),
              ),
            ),
            KeyboardButton(
              child: Icon(Icons.percent, size: 30.0, color: greenColor),
            ),
            KeyboardButton(
              child: buildMathSymbol(FontAwesomeIcons.divide),
            ),
          ]),
          Row(children: [
            KeyboardButton(
              child: Text(
                "7",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              child: Text(
                "8",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              child: Text(
                "9",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              child: buildMathSymbol(FontAwesomeIcons.multiply),
            ),
          ]),
          Row(children: [
            KeyboardButton(
              child: Text(
                "4",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              child: Text(
                "5",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              child: Text(
                "6",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              child: buildMathSymbol(FontAwesomeIcons.minus),
            ),
          ]),
          Row(children: [
            KeyboardButton(
              child: Text(
                "1",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              child: Text(
                "2",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              child: Text(
                "3",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              child: buildMathSymbol(FontAwesomeIcons.plus),
            ),
          ]),
          Row(children: [
            KeyboardButton(
              child: Icon(Icons.replay, size: 30.0),
            ),
            KeyboardButton(
              child: Text(
                "0",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              child: Text(
                ".",
                style: btnTextStyle.copyWith(fontSize: 40.0),
              ),
            ),
            KeyboardButton(
              child: buildMathSymbol(FontAwesomeIcons.equals),
            ),
          ]),
        ],
      ),
    );
  }
}
