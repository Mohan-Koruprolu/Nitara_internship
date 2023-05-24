import 'package:flutter/material.dart';
import 'dart:math';
import 'logic.dart';

class Pageinfo extends StatefulWidget {
  const Pageinfo({super.key});
  @override
  State createState() => PageinfoState();
}

class PageinfoState extends State {
  // var height = 0.0;
  // var weight = 0.0;
  // var bmi = 0.0;
  // var img = [
  //   "https://th.bing.com/th/id/OIP.XJOSqzpR817O9ZPXqgtt2gHafl?w=82&h=349&c=7&r=0&o=5&dpr=1.3&pid=1.7",
  //   "https://th.bing.com/th/id/OIP.MaCmnZkgicn7CjbT297tbwHaPR?w=115&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7",
  //   'https://th.bing.com/th/id/OIP.CwWKuANPjNhg2JapdA89VgHaHa?w=194&h=194&c=7&r=0&o=5&dpr=1.3&pid=1.7'
  // ];
  // var level = 0;
  var val = Logic();
  var bmi;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(hintText: "Enter Weight in kg"),
            onChanged: (value) {
              setState(() {
                val.setweight(
                  double.parse((value == '') ? value = '0' : value = value),
                );
                val.bmiupdate();
              });
            },
          ),
        ),
        Expanded(
            child: TextField(
          decoration: const InputDecoration(hintText: "Enter height in Meters"),
          onChanged: (value) {
            setState(() {
              val.setheight(
                double.parse((value == '') ? value = '0' : value = value),
              );
              val.bmiupdate();
            });
          },
        )),
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.network(val.getimg()[val.getlevel()]),
          ),
        ),
        Text("BMI vlaue being ${bmi = val.getbmi()}")
      ],
    );
  }
}
