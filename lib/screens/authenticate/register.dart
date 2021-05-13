import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleview;
  Register({this.toggleview});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();// Creating an instance of AuthService
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Sign up to brew crew',
        ),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.people),
            label: Text('Sign In'),
            onPressed: (){
              widget.toggleview();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty? 'Enter email' : null,
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(height:20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) => val.length < 6? 'Password should have atleast 6 characters' : null,
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0,),
                  RaisedButton(
                    color: Colors.pink,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                        if(result==null){
                          setState(() {
                          error = 'INvalid entry';
                              loading = false;
                          }
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0
                  ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
