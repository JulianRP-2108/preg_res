import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Usuario {
  @protected
  String id;
  @protected
  String nombre;
  @protected
  String apellido;
  @protected
  String email;
  @protected
  String profileImage;
  @protected
  int puntaje;
  @protected
  int posAnual;
  @protected
  int posMensual;
  @protected
  int preguntas;
  @protected
  int respuestas;

  static final Usuario _user = Usuario._internal();

  Usuario._internal();

  factory Usuario() {
    return _user;
  }

  static void setNombre(String nombre) => _user.nombre = nombre;
  static void setApellido(String apellido) => _user.apellido = apellido;
  static void setId(String id) => _user.id = id;
  static void setEmail(String email) => _user.email = email;
  static void setProfileImage(String image) => _user.profileImage = image;
  static void setPuntaje(int puntaje) => _user.puntaje = puntaje;
  static void setPosAnual(int posAnual) => _user.posAnual = posAnual;
  static void setPosMensual(int posMensual) => _user.posMensual = posMensual;
  static void setRespuestas(int respuestas) => _user.respuestas = respuestas;
  static void setPreguntas(int preguntas) => _user.preguntas = preguntas;

  static String getNombre() => _user.nombre;
  static String getApellido() => _user.apellido;
  static String getId() => _user.id;
  static String getEmail() => _user.email;
  static String getProfileImage() => _user.profileImage;
  static int getPuntaje() => _user.puntaje;
  static int getPosAnual() => _user.posAnual;
  static int getPosMensual() => _user.posMensual;
  static int getRespuestas() => _user.respuestas;
  static int getPreguntas() => _user.preguntas;

  //  ACA cargo los datos al singleton
  static void fromDocument(DocumentSnapshot doc) {
    try {
      Usuario.setEmail(
          doc.get('email')); //Si es que se aprueba el login de google
      Usuario.setNombre(doc.get('nombre'));
      Usuario.setApellido(doc.get('apellido'));
      Usuario.setProfileImage(doc.get('profileImage'));
      Usuario.setId(doc.get('id'));
      Usuario.setPosAnual(doc.get('posAnual'));
      Usuario.setPosMensual(doc.get('posMensual'));
      Usuario.setPuntaje(doc.get('puntaje'));
      Usuario.setPreguntas(doc.get('preguntas'));
      Usuario.setRespuestas(doc.get('respuestas'));
    } catch (e) {
      print(e);
    }
  }

  //  ACA TENGO QUE REGISTRAR AL USUARIO
  //FIJARSE BIEN QUE VA A SER LO QUE SE VA A DEVOLVER
  static Future<bool> almacenarUsuario() async {
    try {
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        'id': Usuario.getId(),
        'nombre': Usuario.getNombre(),
        'apellido': Usuario.getApellido(),
        'email': Usuario.getEmail(),
        'profileImage': Usuario.getProfileImage(),
        'posAnual': Usuario.getPosAnual(),
        'posMensual': Usuario.getPosMensual(),
        'puntaje': Usuario.getPuntaje(),
        'preguntas': Usuario.getPreguntas(),
        'respuestas': Usuario.getRespuestas()
      });
    } catch (e) {
      return false;
    }
    return true;
  }
}
