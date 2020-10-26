import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginState with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loggedIn = false;

  bool isLoggedIn() {
    return this._loggedIn;
  }

  void login(String email, String password) async {
    UserCredential usuario;
    try {
      usuario = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    if (usuario == null) {
      this._loggedIn = false;
    } else {
      this._loggedIn = true;
    }
    notifyListeners();
  }

  void logout() {
    this._loggedIn = false;
    notifyListeners();
  }
}
