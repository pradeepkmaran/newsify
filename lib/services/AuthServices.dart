

import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final authInstance = FirebaseAuth.instance;

  Future userSignUp(String email, String pw) async {
    try{
      UserCredential userCredential = await authInstance.createUserWithEmailAndPassword(email: email, password: pw);
      User? user = userCredential.user;
      return user;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  Future userLogIn(String email, String pw) async {
    try{
      UserCredential userCredential = await authInstance.signInWithEmailAndPassword(email: email, password: pw);
      User? user = userCredential.user;
      return user;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future userSignOut() async {
    await authInstance.signOut();
  }
}