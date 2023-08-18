// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

enum ResultStatus { Null, UserInput, Answer }

class ResultView extends StatelessWidget {
  final largeText = TextStyle(
      fontWeight: FontWeight.w500, color: Colors.white, fontSize: 38.0);

  final smallText = TextStyle(
      fontWeight: FontWeight.w500, color: Colors.white, fontSize: 24.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.bottomRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "89+3",
            style: largeText,
          ),
          Text(
            "= 92",
            style: smallText,
          ),
        ],
      ),
    );
  }
}


/*

null input:
  0

some input:
  <user input>
  = <small answer preview>

answer:
  <small user orignal input>
  = <answer>

*/