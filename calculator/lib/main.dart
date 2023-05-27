import 'package:calculator/logic.dart';
import 'package:flutter/material.dart';
void main(List<String> args) {
  //entry point
  runApp(const SampleApp());
}

///normal body implementation
class SampleApp extends StatefulWidget {
  const SampleApp({super.key});

  @override
  State<SampleApp> createState() => _SampleAppState();
}

class _SampleAppState extends State<SampleApp> {
  String value = '';
  Function backval(String val) {
    return (val) {
      setState(() {
        if (value.length > 1) {
          value = value.substring(0, value.length - 1);
        } else {
          value = '';
        }
      });
    };
  }

  /// call this [output] funtion to evaluate the expression present in the [ value ] by calling a [Sample] object
  Function output(String val) {
    return (val) {
      setState(() {
        Sample a = Sample();
        value = a.parseinput(value);
      });
    };
  }

  /// clearing the expression present in the [value]
  Function clearval(String val) {
    return (val) {
      setState(() {
        value = '';
      });
    };
  }

  /// adding the [val] of the button to the already present [value]
  Function changeval(String val) {
    return (String val) {
      setState(() {
        value = value + val;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Grid Trails"),
        ),
        body: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 0, 118, 181)),
          child: Column(
            // using Expanded Widgets inside cloumn to make the layout
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          border:
                              Border.all(width: 5, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 90,
                            letterSpacing: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              Expanded(
                flex: 2,

                //'https://stackoverflow.com/questions/44183795/how-to-create-gridview-layout-in-flutter' col and row is best for fixed layout rather than grid
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Expanded(
                      child: Row(
                        children: [
                          CalcNumButton(
                            val: "1",
                            function: changeval("1"),
                          ),
                          CalcNumButton(
                            val: "2",
                            function: changeval("2"),
                          ),
                          CalcNumButton(
                            val: "3",
                            function: changeval("3"),
                          ),
                          CalcNumButton(
                            val: "+",
                            customcol: Colors.blue,
                            function: changeval('+'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcNumButton(
                            val: "4",
                            function: changeval("4"),
                          ),
                          CalcNumButton(
                            val: "5",
                            function: changeval("5"),
                          ),
                          CalcNumButton(
                            val: "6",
                            function: changeval("6"),
                          ),
                          CalcNumButton(
                            val: "-",
                            customcol: Colors.green,
                            function: changeval('-'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcNumButton(
                            val: "7",
                            function: changeval("7"),
                          ),
                          CalcNumButton(
                            val: "8",
                            function: changeval("8"),
                          ),
                          CalcNumButton(
                            val: "9",
                            function: changeval("9"),
                          ),
                          CalcNumButton(
                            val: "*",
                            customcol: Colors.grey,
                            function: changeval('*'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcNumButton(
                            val: "0",
                            function: changeval("0"),
                          ),
                          CalcNumButton(
                            val: "Back",
                            customcol: const Color.fromARGB(255, 247, 147, 39),
                            function: backval('|'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcNumButton(
                            val: ".",
                            function: changeval("."),
                          ),
                          CalcNumButton(
                            val: "/",
                            customcol: Colors.cyan,
                            function: changeval('/'),
                          ),
                          CalcNumButton(
                            val: '=',
                            customcol: Colors.blueGrey,
                            function: output('='),
                          ),
                          CalcNumButton(
                            val: 'AC',
                            customcol: Colors.brown,
                            function: clearval('AC'),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// calculator button with optional color value but with
///
/// required
/// + [val]  (Text on the button)
/// + [function] (Funtion corresponding to that button)
class CalcNumButton extends StatefulWidget {
  final Function function;
  final String val;
  final Color? customcol;
  const CalcNumButton(
      {super.key, required this.val, this.customcol, required this.function});

  @override
  State<CalcNumButton> createState() => _CalcNumButtonState();
}

class _CalcNumButtonState extends State<CalcNumButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              widget.function(widget.val);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: (widget.customcol == null)
                ? (const Color.fromARGB(255, 205, 24, 24))
                : widget.customcol,
            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
            textStyle: const TextStyle(fontSize: 20),
          ),
          child: Center(
            child: Text(widget.val),
          ),
        ),
      ),
    );
  }
}
