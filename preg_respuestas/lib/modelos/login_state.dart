import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginState with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loggedIn = false;
  bool _loading = false;

  //TODO: FALTA SETEAR CUAL ES EL USUARIO ACTUAL

  bool isLoading() => this._loading;

  bool isLoggedIn() => this._loggedIn;

  Future<Map<String, dynamic>> login(String email, String password) async {
    _loading = true;
    String mensaje = "";
    Map<String, dynamic> resultado = Map<String, dynamic>();
    this.notifyListeners();

    UserCredential usuario;
    try {
      usuario = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        mensaje = 'No se encontro usuario para ese email.';
      } else if (e.code == 'wrong-password') {
        mensaje = 'Contraseña incorrecta.';
      }
    }
    if (usuario == null) {
      this._loading = false;
      this._loggedIn = false;
    } else {
      this._loading = false;
      this._loggedIn = true;
      print(usuario);
    }
    resultado['logueado'] = _loggedIn;
    resultado['mensaje'] = mensaje;
    this.notifyListeners();
    return resultado;
  }

  //TODO: Aca no solo tengo que registrarlo sino que lo tengo que guardar en la tabla usuarios
  Future<Map<String, dynamic>> registerUser(Map<String, String> datos) async {
    this._loading = true;
    notifyListeners();
    Map<String, dynamic> resultado = Map<String, dynamic>();
    String mensaje = "";
    UserCredential usuario;
    try {
      usuario = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: datos['email'], password: datos['password']);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        mensaje = "La contraseña provista es muy debil";
      } else if (e.code == 'email-already-in-use') {
        mensaje = "La cuenta ingresada ya está en usp";
      } else {
        mensaje = "Se produjo un error, revise sus datos";
      }
    } catch (e) {
      print(e);
      mensaje = "Se produjo un error, intente nuevamente";
    }

    if (usuario == null) {
      this._loading = false;
      this._loggedIn = false;
    } else {
      this._loading = false;
      this._loggedIn = true;
    }

    resultado['mensaje'] = mensaje;
    resultado['registrado'] = _loggedIn;
    this.notifyListeners();
    return resultado;
  }

  void logout() {
    this._loggedIn = false;
    //_auth.signOut();
    this.notifyListeners();
  }
}
