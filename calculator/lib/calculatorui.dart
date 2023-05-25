import 'package:flutter/material.dart';

class Calculatorpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          calcbutton(number: leftvalue),
          calcbutton(number: midvalue),
          calcbutton(number: rightvalue),
        ],
      ),
    );
  }
}

class calcbutton extends StatefulWidget {
  int? value;
  String? val = '';
  calcbutton({Key? key, @required int? number}) : super(key: key) {
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
