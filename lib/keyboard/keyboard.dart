// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:second_flutter_app/calculater_model.dart';

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

    final calcModel = Provider.of<CalculatorModel>(context, listen: false);

    return Container(
      padding: const EdgeInsets.only(
        bottom: 16.0,
        top: 32.0,
        left: 16.0,
        right: 16.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF292D36),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.0),
          topRight: Radius.circular(28.0),
        ),
      ),
      child: Column(
        children: [
          Row(children: [
            KeyboardButton(
              onTap: () { calcModel.reset(); } ,
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
              onTap: () { calcModel.onOperator(Operator.div); } ,
              child: buildMathSymbol(FontAwesomeIcons.divide),
            ),
          ]),
          Row(children: [
            KeyboardButton(
              onTap: () { calcModel.onDigit(7); } ,
              child: Text(
                "7",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              onTap: () { calcModel.onDigit(8); } ,
              child: Text(
                "8",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              onTap: () { calcModel.onDigit(9); } ,
              child: Text(
                "9",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              onTap: () { calcModel.onOperator(Operator.mul); } ,
              child: buildMathSymbol(FontAwesomeIcons.xmark),
            ),
          ]),
          Row(children: [
            KeyboardButton(
              onTap: () { calcModel.onDigit(4); },
              child: Text(
                "4",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              onTap: () { calcModel.onDigit(5); },
              child: Text(
                "5",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              onTap: () { calcModel.onDigit(6); },
              child: Text(
                "6",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              onTap: () { calcModel.onOperator(Operator.sub); } ,
              child: buildMathSymbol(FontAwesomeIcons.minus),
            ),
          ]),
          Row(children: [
            KeyboardButton(
              onTap: () { calcModel.onDigit(1); },
              child: Text(
                "1",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              onTap: () { calcModel.onDigit(2); },
              child: Text(
                "2",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              onTap: () { calcModel.onDigit(3); },
              child: Text(
                "3",
                style: btnTextStyle,
              ),
            ),
            KeyboardButton(
              onTap: () { calcModel.onOperator(Operator.add); } ,
              child: buildMathSymbol(FontAwesomeIcons.plus),
            ),
          ]),
          Row(children: [
            KeyboardButton(
              onTap: () { calcModel.popToken(); },
              child: Icon(Icons.replay, size: 30.0),
            ),
            KeyboardButton(
              onTap: () { calcModel.onDigit(0); },
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
              onTap: () { calcModel.onAnswer(); },
              child: buildMathSymbol(FontAwesomeIcons.equals),
            ),
          ]),
        ],
      ),
    );
  }
}
