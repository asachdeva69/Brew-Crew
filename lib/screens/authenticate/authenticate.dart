import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void ToggleView () {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
   if(showSignIn)
     return SignIn(toggleview : ToggleView);
   else
     return Register(toggleview : ToggleView);
  }
}
