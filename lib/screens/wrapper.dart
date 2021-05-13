import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<TheUser>(context); // Accessing user data from Provider Package

    if(user == null) // Return either home or authenticate widget
      return Authenticate();
    else
    return Home();
  }
}
