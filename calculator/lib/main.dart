import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const SampleApp());
}

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
          print(value);
        } else {
          print(value);
          value = '';
        }
      });
    };
  }

  Function clearval(String val) {
    return (val) {
      setState(() {
        value = '';
        print(value);
      });
    };
  }

  Function changeval(String val) {
    return (String val) {
      setState(() {
        value = value + val;
        print(value);
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
          decoration: BoxDecoration(),
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
                          color: Colors.grey[400],
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

                ///'https://stackoverflow.com/questions/44183795/how-to-create-gridview-layout-in-flutter' col and row is best for fixed layout rather than grid
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Expanded(
                      child: Row(
                        children: [
                          CalcNumButton(
                            val: "1",
                            changeval: changeval("1"),
                          ),
                          CalcNumButton(
                            val: "2",
                            changeval: changeval("2"),
                          ),
                          CalcNumButton(
                            val: "3",
                            changeval: changeval("3"),
                          ),
                          CalcNumButton(
                            val: "+",
                            customcol: Colors.blue,
                            changeval: changeval('+'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcNumButton(
                            val: "4",
                            changeval: changeval("4"),
                          ),
                          CalcNumButton(
                            val: "5",
                            changeval: changeval("5"),
                          ),
                          CalcNumButton(
                            val: "6",
                            changeval: changeval("6"),
                          ),
                          CalcNumButton(
                            val: "-",
                            customcol: Colors.green,
                            changeval: changeval('-'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcNumButton(
                            val: "7",
                            changeval: changeval("7"),
                          ),
                          CalcNumButton(
                            val: "8",
                            changeval: changeval("8"),
                          ),
                          CalcNumButton(
                            val: "9",
                            changeval: changeval("9"),
                          ),
                          CalcNumButton(
                            val: "*",
                            customcol: Colors.grey,
                            changeval: changeval('*'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcNumButton(
                            val: "0",
                            changeval: changeval("0"),
                          ),
                          CalcNumButton(
                            val: "Back",
                            customcol: Colors.pink,
                            changeval: backval('|'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcNumButton(
                            val: ".",
                            changeval: changeval("."),
                          ),
                          CalcNumButton(
                            val: "/",
                            customcol: Colors.cyan,
                            changeval: changeval('/'),
                          ),
                          CalcNumButton(
                            val: '=',
                            customcol: Colors.blueGrey,
                            changeval: changeval('='),
                          ),
                          CalcNumButton(
                            val: 'AC',
                            customcol: Colors.brown,
                            changeval: clearval('AC'),
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

class CalcNumButton extends StatefulWidget {
  final Function changeval;
  final String val;
  final Color? customcol;
  const CalcNumButton(
      {super.key, required this.val, this.customcol, required this.changeval});

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
              widget.changeval(widget.val);
              print("button ${widget.val}");
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                (widget.customcol == null) ? (Colors.black) : widget.customcol,
            foregroundColor: Colors.amber,
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
