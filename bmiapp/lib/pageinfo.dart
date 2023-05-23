import 'package:flutter/material.dart';
import 'dart:math';

class Pageinfo extends StatefulWidget {
  const Pageinfo({super.key});
  @override
  State createState() => PageinfoState();
}

class PageinfoState extends State {
  var height = 0.0;
  var weight = 0.0;
  var bmi = 0.0;
  var img = [
    "https://th.bing.com/th/id/OIP.XJOSqzpR817O9ZPXqgtt2gHafl?w=82&h=349&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    "https://th.bing.com/th/id/OIP.MaCmnZkgicn7CjbT297tbwHaPR?w=115&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    'https://th.bing.com/th/id/OIP.CwWKuANPjNhg2JapdA89VgHaHa?w=194&h=194&c=7&r=0&o=5&dpr=1.3&pid=1.7'
  ];
  var level = 0;
  void bmiupdate() {
    if (bmi < 18.5) {
      level = 0;
    } else if (bmi >= 18.5 && bmi < 25) {
      level = 1;
    } else {
      level = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              child: TextField(
                decoration: InputDecoration(hintText: "Enter Weight in kg"),
                onChanged: (value) {
                  setState(() {
                    if (value != '') {
                      weight = double.parse(value);
                      bmi = weight / pow(height / 100, 2);
                    } else {
                      weight = 1.0;
                      bmi = 1.0;
                    }
                    bmiupdate();
                  });
                },
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: TextField(
              decoration: InputDecoration(hintText: "Enter height in Meters"),
              onChanged: (value) {
                setState(() {
                  if (value != '') {
                    height = double.parse(value);
                    bmi = weight / pow(height / 100, 2);
                  } else {
                    height = 1.0;
                    bmi = 1.0;
                  }
                  bmiupdate();
                });
              },
            ),
          )),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(img[level]),
            ),
          ),
          Container(child: Text("BMI vlaue being $bmi"))
        ],
      ),
    );
  }
}
