import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:preg_respuestas/modelos/Usuario.dart';

class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static signInWithEmail({String email, String password}) async {
    final resp = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    final User user = resp.user;
    return user;
  }

  static register(Map<String, String> datos) async {
    //Dejo todo cargado en un singleton para despues cargarlo en la base de datos
    Usuario.setEmail(datos['email']); //Si es que se aprueba el login de google
    Usuario.setNombre(datos['nombre']);
    Usuario.setApellido(datos['apellido']);
    Usuario.setProfileImage("");
    Usuario.setId("");
    Usuario.setPosAnual(0);
    Usuario.setPosMensual(0);
    Usuario.setPuntaje(0);
    Usuario.setPreguntas(0);

    final UserCredential resp = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: datos['email'], password: datos['password']);
    return resp.user;
  }

  static logOut() async {
    _auth.signOut();
  }
}
