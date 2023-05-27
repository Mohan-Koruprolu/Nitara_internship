import 'dart:collection';
class Trail {
  bool checkOperator(String c) {
    return c == "+" || c == "-" || c == "*" || c == "/" || c == "^";
  }

  String infixToPostfix(String infix) {
    Map<String, int> precedence = {"+": 1, "-": 1, "*": 2, "/": 2, "^": 3};
    Queue<String> output = Queue();
    Queue<String> stack = Queue();
    for (int i = 0; i < infix.length; i++) {
      String c = infix[i];
      if (precedence.containsKey(c)) {
        while (
            stack.isNotEmpty && (precedence[c]! <= precedence[stack.last]!)) {
          output.add(stack.removeLast());
        }
        stack.addLast(c);
      } else {
        output.add(c);
      }
    }
    while (stack.isNotEmpty) {
      output.add(stack.removeLast());
    }
    return output.join("");
  }
}