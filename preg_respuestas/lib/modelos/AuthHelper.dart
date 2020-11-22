import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static signInWithEmail({String email, String password}) async {
    final resp = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    final User user = resp.user;
    return user;
  }

  static register({String email, String password}) async {
    final resp = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    final User user = resp.user;
    return user;
  }

  static logOut() async {
    _auth.signOut();
  }
}
