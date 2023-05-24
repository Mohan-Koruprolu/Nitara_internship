import 'dart:math';

class Logic {
  RequestModel? a;
  ResponseModel? b;
  String? response;
  Logic.error() {
    response = 'error in values';
  }
  Logic(double height, double weight) {
    a = RequestModel(height, weight);
    b = ResponseModel(getbmi()!);
  }

  double? getbmi() {
    return a?.bmi;
  }

  String? getimg() {
    return b?.getimg();
  }
}

class RequestModel {
  double _height = 0.0;
  double _weight = 0.0;
  double _bmi = 0.0;
  RequestModel(this._height, this._weight)
      : _bmi = _weight / pow(_height / 100, 2);
  get height {
    return _height;
  }

  get weight {
    return _weight;
  }

  get bmi {
    return _bmi;
  }
}

class ResponseModel {
  double _bmi = 0.0;
  double _height = 0.0;
  double _weight = 0.0;
  List<String> img = [
    "https://th.bing.com/th/id/OIP.XJOSqzpR817O9ZPXqgtt2gHafl?w=82&h=349&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    "https://th.bing.com/th/id/OIP.MaCmnZkgicn7CjbT297tbwHaPR?w=115&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    'https://th.bing.com/th/id/OIP.CwWKuANPjNhg2JapdA89VgHaHa?w=194&h=194&c=7&r=0&o=5&dpr=1.3&pid=1.7'
  ];
  int _level = 0;
  ResponseModel(double bmi) {
    _bmi = bmi;
    if (_bmi < 18.5) {
      _level = 0;
    } else if (_bmi >= 18.5 && _bmi < 25) {
      _level = 1;
    } else {
      _level = 2;
    }
  }
  String getimg() {
    return img[_level];
  }
}
