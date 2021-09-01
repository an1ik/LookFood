import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'create_acc.dart';
import 'forgot_password.dart';
import 'homepage.dart';
import '../services/auth.dart';
import '../services/my_icons.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email; // хранит маил
  String _password; // хранит пароль
  bool showLogin = true; //При значение true скрывает вводи-мый текст в поле

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
          padding: EdgeInsets.only(
            bottom: 30,
          ),
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Stack(children: <Widget>[
                  Image(
                      image: AssetImage('assets/images/girl.jpg'),
                      width: double.infinity),
                  Positioned(
                    child: IconButton(
                      icon: Icon(MyIcons.cross),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                    right: 0,
                    top: 26,
                  ),
                ]),
                Padding(
                    padding: EdgeInsets.only(top: 13),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/food_easy.png')),
                            )),
                        Spacer(
                          flex: 1,
                        )
                      ],
                    ))
              ])));
    }

    Widget _input(String hint, TextEditingController controller, bool obscure) {
      return Container(
        height: 50,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
            hintStyle: TextStyle(
                fontFamily: 'Krub_L',
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF888888)),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.4)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black87, width: 0.6)),
          ),
        ),
      );
    }

    void _buttonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      User user = await _authService.singInWithEmailAndPassword(
          _email.trim(), _password.trim());

      if (user == null) {
        Fluttertoast.showToast(
            msg: "Can`t SingIn you! Please check your email and password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        _emailController.clear();
        _passwordController.clear();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          _logo(),
          Padding(
            padding: EdgeInsets.only(left: 10, bottom: 13),
            child: Text(
              'Registered customer',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'HeliosAntique',
                  fontSize: 13,
                  color: Colors.black),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(1),
              child: _input('E-mail', _emailController, false)),
          Padding(
              padding: EdgeInsets.all(1),
              child: _input('Password', _passwordController, true)),
          Padding(
              padding: EdgeInsets.only(left: 5, bottom: 10),
              child: Container(
                  height: 29,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()),
                      );
                    },
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Krub_L',
                          fontSize: 11,
                          color: Colors.black),
                    ),
                  ))),
          Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      splashColor: Color(0xff88C050),
                      highlightColor: Color(0xff88C050),
                      color: Color(0xff6F9648),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Krub_R',
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        _buttonAction();
                      }))),
          Padding(
              padding: EdgeInsets.only(top: 7, left: 5, right: 5),
              child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    color: Colors.white,
                    child: Text(
                      'Create account',
                      style: TextStyle(
                        color: Color(0xff6F9648),
                        fontFamily: 'Krub_R',
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateAcc()),
                      );
                    },
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0.5, color: Color(0xff727272))))),
          Spacer(),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: FlatButton(
              child: Container(
                  child: SvgPicture.asset(
                "assets/icons/GoogleSignIn.svg",
                height: 30,
                width: 30,
              )),
              onPressed: () {},
            ),
          )),
          Spacer()
        ]));
  }
}


create_acc.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/screens/sign_out_acc.dart';
import '../services/my_icons.dart';
import '../services/auth.dart';

class CreateAcc extends StatefulWidget {
  CreateAcc({Key key}) : super(key: key);

  @override
  _CreateAccState createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  String _email;
  String _password;
  String _name;
  String _surname;
  bool showLogin = true;

  AuthService _authService = AuthService();


  void _buttonAction() async {
    _email = _emailController.text;
    _name = _nameController.text;
    _surname = _surnameController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty || _surname.isEmpty || _name.isEmpty)
      return;

    User user = await _authService.registerInWithEmailAndPassword(
        _email.trim(), _password.trim());
    if (user == null) {
    } else {
      _emailController.clear();
      _passwordController.clear();
      _surnameController.clear();
      _nameController.clear();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuthPage()),          
        );
    }
  }

  Widget _input(String hint, TextEditingController controller, bool ob-scure) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(
          left: 15, right: MediaQuery.of(context).size.width * 0.18),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontFamily: 'Krub_L', fontSize: 16, color: Color(0xFF888888)),
          hintText: hint,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Stack(children: <Widget>[
              Padding(
                child: Align(
                  child: SvgPicture.asset('assets/images/Sign Up.svg',
                      fit: BoxFit.fitHeight),
                  alignment: Alignment.centerLeft,
                ),
                padding: EdgeInsets.only(
                    top: 15, left: MediaQuery.of(context).size.width * 0.06),
              ),
              Positioned(
                child: IconButton(
                  icon: Icon(MyIcons.cross),
                  color: Color(0xFFBBD356),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                right: 0,
                top: -15,
              ),
            ]),
            Spacer(flex: 50),
            Expanded(
                child: Padding(
                  child: FittedBox(
                    child: Text(
                      'How would you like us to adress you?',
                      style: TextStyle(fontFamily: 'HeliosAnique'),
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
                flex: 28),
            Spacer(flex: 15),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(1),
                  child: _input('Name*', _nameController, false)),
              flex: 50,
            ),
            Spacer(flex: 20),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(1),
                  child: _input('Surname*', _surnameController, false)),
              flex: 50,
            ),
            Spacer(flex: 25),
            Expanded(
                child: Padding(
                  child: FittedBox(
                    child: Text(
                      'Enter an e-mail and password to access\nyour account wherever and whenever\nyou like.',
                      style: TextStyle(fontFamily: 'HeliosAnique'),
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
                flex: 75),
            Spacer(flex: 15),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(1),
                  child: _input('E-mail*', _emailController, false)),
              flex: 50,
            ),
            Spacer(flex: 20),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(1),
                  child: _input('Password*', _passwordController, false)),
              flex: 50,
            ),
            Spacer(flex: 30),
            Spacer(flex: 150),
            Spacer(flex: 40),
            Expanded(
                child: Container(
                  width: double.infinity,
                  child: TextButton(
                    child: FittedBox(
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Krub_R',
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                    onPressed: () {_buttonAction();},
                  ),
                  color: Color(0xFFBBD356),
                  margin: EdgeInsets.symmetric(horizontal: 35),
                ),
                flex: 50),
            Spacer(flex: 10),
            Expanded(
                child: Padding(
                  child: FittedBox(
                    child: Text(
                      'By clicking on "Register", you agree to the security\nand privacy policy.',
                      style: TextStyle(fontFamily: 'HeliosAnique'),
                      textAlign: TextAlign.center,
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.18),
                ),
                flex: 50),
            Spacer(flex: 15),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}


