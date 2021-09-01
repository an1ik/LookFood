import 'package:flutter/material.dart';
import '../services/my_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'e-mail.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Align(
              child: IconButton(
                icon: Icon(MyIcons.cross),
                color: Color(0xFFBBD356),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              alignment: Alignment.topRight,
            ),
            Spacer(flex: 10),
            Expanded(
              child: Padding(
                child: FittedBox(
                  child: SvgPicture.asset('assets/ForgotPassword.svg',
                      fit: BoxFit.fitHeight),
                  fit: BoxFit.fitWidth,
                ),
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.11,
                    right: MediaQuery.of(context).size.width * 0.02),
              ),
              flex: 35,
            ),
            Spacer(flex: 35),
            Expanded(
              child: Padding(
                child: FittedBox(
                  child: Text(
                    'Enter your email address and we\nwill send you instructions for\npassword recovery.',
                    style: TextStyle(fontFamily: 'HeliosAnique'),
                    textAlign: TextAlign.center,
                  ),
                  fit: BoxFit.fitWidth,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.15),
              ),
              flex: 80,
            ),
            Spacer(flex: 60),
            Expanded(
              child: Container(
                width: double.infinity,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Krub_R',
                    ),
                    hintText: ' E-mail*',
                  ),
                ),
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                decoration: BoxDecoration(border: Border.all(width: 0.5)),
                padding: EdgeInsets.only(left: 8),
              ),
              flex: 45,
            ),
            Spacer(flex: 50),
            Expanded(
                child: Container(
                  width: double.infinity,
                  child: TextButton(
                    child: FittedBox(
                      child: Text(
                        'SEND',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Krub_R',
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EMail()),
                      );
                    },
                  ),
                  color: Color(0xFFBBD356),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                ),
                flex: 45),
            Spacer(flex: 390),
          ],
        ),
      ),
    );
  }
}


e-mail.dart
import 'package:flutter/material.dart';
import 'sign_out_acc.dart';
import '../services/my_icons.dart';

class EMail extends StatelessWidget {
  const EMail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Doggie.jpg'), fit: BoxFit.fill),
          ),
        ),
        Positioned(
            child: IconButton(
              icon: Icon(MyIcons.cross),
              color: Colors.white,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AuthPage(),
                  ),
                  (route) => false,
                );
              },
            ),
            right: 0,
            top: 26),
        Positioned(
          child: Text(
            'We\nhave\nsent\nyou an\nemail',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Krub_R',
              fontSize: 44,
              fontWeight: FontWeight.w200,
            ),
          ),
          left: MediaQuery.of(context).size.width * 0.04,
          top: MediaQuery.of(context).size.height * 0.13,
        ),
        Positioned(
          child: Text(
            'Please check for spam\nLink will be available during 72 hours',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Krub_R',
              fontSize: 14,
              fontWeight: FontWeight.w100,
            ),
            textAlign: TextAlign.center,
          ),
          bottom: 15,
          left: 0,
          right: 0,
        ),
      ]),
    );
  }
}
