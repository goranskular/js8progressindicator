import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'js8progressindicator.dart';

void main() {
  runApp(MaterialApp(title: 'App', home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Js8Mode mode = Js8Mode.normal();

  @override
  void initState() {
    _showTime();
    super.initState();
  }

  void _showTime() {
    new Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      setState(() {});
    });
  }

  void _toggleMode() {
    switch (mode.name) {
      case 'Slow':
        mode.setModeWithSeconds = Js8Mode.normalSecs;
        break;
      case 'Normal':
        mode.setModeWithSeconds = Js8Mode.fastSecs;
        break;
      case 'Fast':
        mode.setModeWithSeconds = Js8Mode.turboSecs;
        break;
      case 'Turbo':
        mode.setModeWithSeconds = Js8Mode.slowSecs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('js8Progress'),
        elevation: 0,
        toolbarHeight: kToolbarHeight - 4,
        actions: [
          Container(
            alignment: Alignment.center,
            child: Text(
                '${DateFormat('Hms').format(DateTime.now())} ${mode.name} (${mode.seconds}s)'),
          ),
          Container(
            child: IconButton(
                icon: Icon(Icons.pie_chart),
                onPressed: () {
                  setState(() {
                    _toggleMode();
                  });
                }),
          ),
        ],
      ),
      body: Js8ProgressIndicator(js8mode: mode),
    );
  }
}
