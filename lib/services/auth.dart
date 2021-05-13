import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;  // Creating an instance of Firebase usage

  //create user object based on Firebase user
  TheUser _userfromFirebaseUser(User user){ // Converting FirebaseUser to our own TheUser
    return user != null ? TheUser(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<TheUser> get user{
    return _auth.authStateChanges().map(_userfromFirebaseUser);
    // .map( (Firebase user) => (_userfromFirebaseUser user) )
  }


  // sign in anonymously
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously(); // Way to sign in anonymously into Firebase
      User user = result.user;
      return _userfromFirebaseUser(user);
    }
    catch(e){
      print('error is ${e.toString()}');
      return null;
    }
  }
  //sign in with email
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userfromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  // register
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      // create a new document for the user in Firestore
      print(user.uid);
      await DatabaseService(uid: user.uid).updateUserData('0', 'Qadri Singh', 0);
      return _userfromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

 // sign out
  Future SignOut() async{
      try{
        return await _auth.signOut();
      }
      catch(e) {
        print(e.toString());
        return null;
      }
  }
}