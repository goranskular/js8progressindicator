import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Js8Mode {
  int seconds;
  String name;
  Js8Mode(int seconds) {
    this.seconds = seconds;
    this.setModeWithSeconds = seconds;
  }

  set setModeWithSeconds(int seconds) {
    switch (seconds) {
      case slowSecs:
        name = 'Slow';
        this.seconds = Js8Mode.slowSecs;
        break;
      case normalSecs:
        name = 'Normal';
        this.seconds = Js8Mode.normalSecs;
        break;
      case fastSecs:
        name = 'Fast';
        this.seconds = Js8Mode.fastSecs;
        break;
      case turboSecs:
        name = 'Turbo';
        this.seconds = Js8Mode.turboSecs;
        break;
      default:
        {
          print('wrong seconds value, defaulting to Normal 15 seconds');
          name = 'normal';
          this.seconds = Js8Mode.normalSecs;
        }
        break;
    }
  }

  static const int slowSecs = 30;
  static const int normalSecs = 15;
  static const int fastSecs = 10;
  static const int turboSecs = 6;

  factory Js8Mode.slow() {
    return Js8Mode(Js8Mode.slowSecs);
  }
  factory Js8Mode.normal() {
    return Js8Mode(Js8Mode.normalSecs);
  }

  factory Js8Mode.fast() {
    return Js8Mode(Js8Mode.fastSecs);
  }

  factory Js8Mode.turbo() {
    return Js8Mode(Js8Mode.turboSecs);
  }
}

class Js8ProgressIndicator extends StatefulWidget {
  Js8Mode js8mode;
  Js8ProgressIndicator({this.js8mode});
  @override
  _Js8ProgressIndicatorState createState() => _Js8ProgressIndicatorState();
}

class _Js8ProgressIndicatorState extends State<Js8ProgressIndicator> {
  int _lastsec = 1;
  double _animationValue = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    int milliseconds;
    new Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      milliseconds =
          (DateTime.now().second * 1000 + DateTime.now().millisecond) %
              (widget.js8mode.seconds * 1000);
      setState(() {
        _animationValue = milliseconds / (widget.js8mode.seconds * 1000);
      });

      int _seconds = int.parse(DateFormat('s').format(DateTime.now()));
      if (_seconds % widget.js8mode.seconds == 0 && _seconds != _lastsec) {
        _lastsec = _seconds;
        print('miliseconds $milliseconds');
        print('new ${widget.js8mode.seconds}s period');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.red,
      value: _animationValue,
    );
  }
}
