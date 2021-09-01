import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/screens/profile.dart';
import 'package:food/screens/sign_out_acc.dart';
import 'package:provider/provider.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    return (user != null) ? Profile() : AuthPage();
  }
}
