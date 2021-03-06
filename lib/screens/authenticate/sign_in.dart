import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
    
    class SignIn extends StatefulWidget {
      final Function toggleview;
      SignIn({this.toggleview});
    
      @override
      _SignInState createState() => _SignInState();
    }
    
    class _SignInState extends State<SignIn> {

      final AuthService _auth = AuthService(); // Creating an instance of AuthService
      final _formKey = GlobalKey<FormState>();
      bool loading = false;

      String email = '';
      String password = '';
      String error = '';

      @override
      Widget build(BuildContext context) {
        return loading? Loading() : Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            backgroundColor: Colors.brown[400],
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              'Sign in to brew crew',
            ),
            actions: [
              FlatButton.icon(
                icon: Icon(Icons.people),
                label: Text('Register'),
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
                       'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if(result==null){
                            setState(() {
                              error = 'COuld not log in';
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
              /* RaisedButton(
                child: Text(
                  'Sign in anonymously',
                ),
                onPressed: () async {
                  dynamic result = await _auth.signInAnon(); // Trying to sign in anonymously
                  if(result==null) {
                    print('error signing in');
                  }
                  else
                 {
                    print('signed in - ${result.uid}');
                  }
                },
              ) */
            ),
          ),
        );
      }
    }
    