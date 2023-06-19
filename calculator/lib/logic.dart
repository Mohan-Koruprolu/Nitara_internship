import 'package:math_expressions/math_expressions.dart';

class Sample {
  String parseinput(String input) {
    RegExp expression =
        RegExp(r'^[+-]?[0-9]+(\.[0-9]+)?([+\-*/]{1}[+-]?[0-9]+(\.[0-9]+)?)*$');
    if (expression.hasMatch(input)) {
      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } else {
      return "ERROR";
    }
  }
}
