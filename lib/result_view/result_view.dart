// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_flutter_app/calculater_model.dart';

final largeText =
    TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 38.0);

final smallText =
    TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 24.0);

const textAnimDuration = Duration(milliseconds: 100);

class ResultView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.bottomRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          _UserQuery(),
          _Answer(),
        ],
      ),
    );
  }
}

class _UserQuery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorModel>(builder: (context, calcModel, child) {
      var query = "0";

      if (calcModel.tokens.isNotEmpty) {
        var buffer = new StringBuffer();
        for (final token in calcModel.tokens) {
          switch (token) {
            case ValueToken tk:
              buffer.write(tk.value.toString());
              break;
            case OperatorToken tk:
              buffer.write(tk.op.symbol);
              break;
            case IncompleteValueToken tk:
              buffer.write(tk.input);
              break;
          }
        }
        query = buffer.toString();
      }

      return AnimatedDefaultTextStyle(
        duration: textAnimDuration,
        key: ValueKey(calcModel.status == ResultStatus.Null),
        style: calcModel.status == ResultStatus.Answer ? smallText : largeText,
        child: Text(
          query,
        ),
      );
    });
  }
}

class _Answer extends StatelessWidget {
  final smallFaded = smallText.copyWith(color: const Color(0xFFA6A6A6));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<CalculatorModel>(builder: (context, calcModel, child) {
      if (calcModel.status == ResultStatus.Null) return SizedBox.shrink();

      final style =
          calcModel.status == ResultStatus.Answer ? largeText : smallFaded;

      return AnimatedDefaultTextStyle(
        style: style,
        duration: textAnimDuration,
        child: Text(
          "= " + calcModel.evaluate().toString(),
        ),
      );
    });
  }
}
