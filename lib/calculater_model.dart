import 'dart:collection';

import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class CalculatorModel extends ChangeNotifier {
  final List<Token> _tokens = [];

  UnmodifiableListView<Token> get tokens => UnmodifiableListView(_tokens);

  void onDigit(int value) {
    print("CalculatorModel::onDigit(${value})");
    var tail = _tokens.lastOrNull;

    if (tail == null || tail is OperatorToken) {
      _tokens.add(IncompleteValueToken(value));
    } else {
      var incomplete = tail as IncompleteValueToken;
      incomplete.append(value);
    }

    this.notifyListeners();
  }

  void onOperator(Operator op) {
    print("CalculatorModel::onOperator(${op.symbol})");
    if (_tokens.length == 0)
      // An expression cannot start with an operator.
      return;

    if (_tokens.last is OperatorToken) {
      // Replace the existing operator with this
      _tokens.last = OperatorToken(op);
    } else if (_tokens.last is IncompleteValueToken) {
      _tokens.last =
          ValueToken((_tokens.last as IncompleteValueToken).toCompleteValue());
      _tokens.add(OperatorToken(op));
    } else {
      return;
    }

    this.notifyListeners();
  }

  void reset() {
    print("CalculatorModel::reset()");
    _tokens.clear();
    this.notifyListeners();
  }
}

abstract class Token {
  Key makeKey() => ObjectKey(this);
}

class ValueToken extends Token {
  final int value;

  ValueToken(this.value);
}

class Operator {
  final String symbol;
  final int precedence;

  Operator._(this.symbol, this.precedence);

  static Operator get add => Operator._("+", 1);
  static Operator get sub => Operator._("-", 1);
  static Operator get mul => Operator._("x", 1);
  static Operator get div => Operator._("/", 1);
}

class OperatorToken extends Token {
  final Operator op;

  OperatorToken(this.op);
}

class IncompleteValueToken extends Token {
  String _input;

  IncompleteValueToken([int? digit]) : this._input = digit?.toString() ?? "";

  void append(int digit) {
    _input += digit.toString();
  }

  int toCompleteValue() {
    return 0;
  }

  @override
  Key makeKey() => ValueKey(_input);
}
