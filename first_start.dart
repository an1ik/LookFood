import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:food/screens/homepage.dart';
import 'package:food/screens/onbording_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstStart extends StatefulWidget {
  @override
  FirstStartState createState() => new FirstStartState();
}

class FirstStartState extends State<FirstStart>
    with AfterLayoutMixin<FirstStart> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Onbordind()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,));
  }
}

