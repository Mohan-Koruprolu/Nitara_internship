import 'package:flutter/material.dart';
import 'logic.dart';

class Pageinfo extends StatefulWidget {
  const Pageinfo({super.key});
  @override
  State createState() => PageinfoState();
}

class PageinfoState extends State {
  String? img;
  double? _bmi;
  double height = 0;
  double weight = 0;
  TextEditingController _heightvalues = TextEditingController();
  TextEditingController _weightvalues = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            controller: _heightvalues,
            decoration: const InputDecoration(hintText: "Enter Weight in kg"),
          ),
        ),
        Expanded(
            flex: 2,
            child: TextField(
              controller: _weightvalues,
              decoration:
                  const InputDecoration(hintText: "Enter height in Meters"),
            )),
        Expanded(
            child: SizedBox(
          child: ElevatedButton(
            onPressed: () {
              valchange(_heightvalues, _weightvalues);
            },
            child: const Text("Submit the values"),
          ),
        )),
        const Expanded(
            flex: 1,
            child: SizedBox(
              height: 20,
            )),
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.network(img ??=
                "https://th.bing.com/th/id/OIP.XJOSqzpR817O9ZPXqgtt2gHafl?w=82&h=349&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
          ),
        ),
        Expanded(flex: 2, child: Text("BMI vlaue being $_bmi"))
      ],
    );
  }

  void valchange(TextEditingController height, TextEditingController weight) {
    setState(() {
      try {
        var val = Logic(
            double.parse((height.value.text)), double.parse(weight.value.text));
        img = val.getimg();
        _bmi = val.getbmi();
      } catch (e) {
        var val = Logic.error();
        img = val.getimg();
        _bmi = val.getbmi();
      }
    });
  }
}
