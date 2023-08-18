// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import 'keyboard/keyboard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF22252D),
        width: double.infinity,
        child: Column(
          children: [
            _Calculations(),
            Keyboard(),
          ],
        ),
      ),
    );
  }
}

class _Calculations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //color: Colors.deepPurple[600],
        child: Center(
          child: Container(
            child: Text("Calculations 2"),
          ),
        ),
      ),
    );
  }
}


