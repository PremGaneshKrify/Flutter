import 'dart:developer';
import 'package:chatting_using_firebase/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  Usermodel? _userFromFirebaseUser(User user) {
    log("Auth services called....................");
    log(Usermodel(uid: user.uid)
        .toString()); // ignore: unnecessary_null_comparison
    return Usermodel(uid: user.uid);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signinWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      log("we are in signinWithEmailAndPassword in side auth file");
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } on FirebaseAuthException catch (e) {
      var v = e.toString().split("] ");
      return v[1];
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
    } on FirebaseAuthException catch (e) {
      var v = e.toString().split("] ");
      return v[1];
    } catch (e) {
      log(e.toString());
      return e;
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      var v = e.toString().split("] ");
      return v[1];
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      var v = e.toString().split("] ");
      return v[1];
    } catch (e) {
      log(e.toString());
    }
  }
}
