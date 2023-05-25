import 'package:flutter/material.dart';

typedef Commonstring = void Function(String val);

class Calculatorpage extends StatelessWidget {
  Commonaccess x = Commonaccess();
  @override
  Widget build(BuildContext context) {
    int b = x.val;
    return Container(
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 197, 196, 196),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(child: Text("hello")),
            ),
          )),
          Rowwiseelements(leftvalue: 1, midvalue: 2, rightvalue: 3),
          Rowwiseelements(leftvalue: 4, midvalue: 5, rightvalue: 6),
          Rowwiseelements(leftvalue: 7, midvalue: 8, rightvalue: 9),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: [
                calcoperand(
                  operand: "+",
                ),
                calcoperand(
                  operand: "-",
                ),
                calcoperand(
                  operand: "*",
                ),
                calcoperand(
                  operand: "/",
                ),
                calcoperand(
                  operand: '=',
                ),
                calcoperand(
                  operand: 'Clear',
                ),
                calcoperand(
                  operand: 'Del',
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class calcoperand extends StatefulWidget {
  late String operand;
  calcoperand({Key? key, required this.operand}) : super(key: key);

  @override
  State<calcoperand> createState() => _calcoperandState();
}

class _calcoperandState extends State<calcoperand> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {},
          child: Center(
            child: Text(widget.operand),
          ),
        ),
      ),
    );
  }
}

class Rowwiseelements extends StatelessWidget {
  final int leftvalue;
  final int midvalue;
  final int rightvalue;
  int val = 0;
  Rowwiseelements(
      {Key? key,
      required this.leftvalue,
      required this.midvalue,
      required this.rightvalue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          calcbutton(
            number: leftvalue,
            callbackFn: (val) {
              print(val + "inside row widget");
            },
          ),
          calcbutton(
              number: midvalue,
              callbackFn: (val) {
                print(val + "inside row widget");
              }),
          calcbutton(
              number: rightvalue,
              callbackFn: (val) {
                print(val + "inside row widget");
              }),
        ],
      ),
    );
  }
}

class calcbutton extends StatefulWidget {
  int? value;
  String? val = '';
  Commonstring callbackFn;
  calcbutton({Key? key, @required int? number, required this.callbackFn})
      : super(key: key) {
    value = number;
  }

  @override
  State<calcbutton> createState() => _calcbuttonState();
}

class _calcbuttonState extends State<calcbutton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 10,
            textStyle: TextStyle(color: Colors.black, fontSize: 10),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            side: BorderSide(color: Colors.black, width: 3),
            shadowColor: Colors.grey),
        onPressed: () {
          widget.callbackFn.call(widget.value.toString());
          setState(() {
            print(widget.value);
          });
        },
        child: Center(
          child: Text("${widget.value}"),
        ),
      ),
    ));
  }
}

class Commonaccess {
  List<int> a = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int val = 0;

  Commonaccess();
  int onvalchange(input) {
    return val = a[input];
  }
}
