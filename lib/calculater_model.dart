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
    if (_tokens.isEmpty)
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

  void popToken() {
    print("CalculatorModel::pop()");
    if (_tokens.isNotEmpty) {
      bool deleteToken = false;

      switch (_tokens.last) {
        case IncompleteValueToken tk:
          tk.popLastDigit();
          deleteToken = tk.input.isEmpty;
          break;

        case OperatorToken():
          deleteToken = true;
          break;

        default:
          break;
      }

      if (deleteToken) {
        _tokens.removeLast();
        if (_tokens.lastOrNull case ValueToken(value: var value)) {
          _tokens.removeLast();
          _tokens.add(IncompleteValueToken(value));
        }
      }

      this.notifyListeners();
    }
  }

  int evaluate() {
    if (_tokens.isEmpty) return 0;

    final List<int> operands = [];
    final List<Operator> ops = [];

    int numTokens = _tokens.length;

    mainloop:
    for (int i = 0; i < numTokens; ++i) {
      //final token = _tokens[i];
      switch (_tokens[i]) {
        case ValueToken(value: var value):
          operands.add(value);
          break;

        case IncompleteValueToken tk:
          operands.add(tk.toCompleteValue());
          break;

        case OperatorToken(op: var op):
          {
            if (i == numTokens - 1) {
              // This operator is at the end. Should be ignored
              break mainloop;
            }

            while (ops.isNotEmpty) {
              if (ops.last.precedence < op.precedence) break;

              final expOp2 = operands.removeLast();
              final expOp1 = operands.removeLast();
              final expOp = ops.removeLast();

              operands.add(expOp.evaluater.call(expOp1, expOp2));
            }

            ops.add(op);
            break;
          }
      }
    }

    while (ops.isNotEmpty) {
      final expOp2 = operands.removeLast();
      final expOp1 = operands.removeLast();
      final expOp = ops.removeLast();

      operands.add(expOp.evaluater.call(expOp1, expOp2));
    }

    return operands.first;
  }
}

sealed class Token {
  Key makeKey() => ObjectKey(this);
}

class ValueToken extends Token {
  final int value;

  ValueToken(this.value);
}

typedef OperatorFunc = int Function(int a, int b);

class Operator {
  final String symbol;
  final int precedence;
  final OperatorFunc evaluater;

  const Operator._(this.symbol, this.precedence, this.evaluater);

  static Operator get add => Operator._("+", 1, (a, b) => a + b);
  static Operator get sub => Operator._("-", 1, (a, b) => a - b);
  static Operator get mul => Operator._("*", 2, (a, b) => a * b);
  static Operator get div => Operator._("/", 2, (a, b) => (a / b).toInt());

  bool operator ==(Object other) {
    return other is Operator &&
        other.symbol == symbol &&
        other.precedence == precedence;
  }
}

class OperatorToken extends Token {
  final Operator op;

  OperatorToken(this.op);
}

class IncompleteValueToken extends Token {
  String _input;
  String get input => _input;

  IncompleteValueToken([int? digit]) : _input = digit?.toString() ?? "";

  void append(int digit) {
    _input += digit.toString();
  }

  void popLastDigit() {
    if (_input.isNotEmpty)
      _input = _input.substring(0, _input.length - 1);
  }

  int toCompleteValue() {
    return int.parse(_input);
  }

  @override
  Key makeKey() => ValueKey(_input);
}
