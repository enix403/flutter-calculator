// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class KeyboardButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const KeyboardButton({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: EdgeInsets.all(6.0),
          child: Material(
            color: Colors.transparent,
            child: buildInkWell(),
          ),
        ),
      ),
    );
  }

  InkWell buildInkWell() {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color(0xFF272B33),
        ),
        child: Center(child: child),
      ),
    );
  }
}
