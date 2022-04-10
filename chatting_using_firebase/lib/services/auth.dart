import 'dart:developer';

import 'package:chatting_using_firebase/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  Usermodel? _userFromFirebaseUser(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? Usermodel(uid: user.uid) : null;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signinWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      log("we are in signupwithemail in side auth file");
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      log(e.toString());
    }
  }

  Future signUpWithEmailAndPassoword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      log(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
