import 'dart:math';

class Logic {
  var _height = 0.0;
  var _weight = 0.0;
  var _bmi = 0.0;
  var img = [
    "https://th.bing.com/th/id/OIP.XJOSqzpR817O9ZPXqgtt2gHafl?w=82&h=349&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    "https://th.bing.com/th/id/OIP.MaCmnZkgicn7CjbT297tbwHaPR?w=115&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    'https://th.bing.com/th/id/OIP.CwWKuANPjNhg2JapdA89VgHaHa?w=194&h=194&c=7&r=0&o=5&dpr=1.3&pid=1.7'
  ];
  var _level = 0;
  double getheight() {
    return _height;
  }

  double getweight() {
    return _weight;
  }

  void setheight(height) {
    _height = height;
    bmicalc();
  }

  void bmicalc() {
    if (_height > 0 && _weight > 0) {
      _bmi = _weight / pow(_height / 100, 2);
    } else {
      _bmi = 0;
    }
  }

  void setweight(weight) {
    _weight = weight;
    bmicalc();
  }

  int getlevel() {
    return _level;
  }

  void setlevel(int level) {
    _level = level;
  }

  List getimg() {
    return img;
  }

  double getbmi() {
    return _bmi;
  }

  void bmiupdate() {
    if (_bmi < 18.5) {
      _level = 0;
    } else if (_bmi >= 18.5 && _bmi < 25) {
      _level = 1;
    } else {
      _level = 2;
    }
  }
}
