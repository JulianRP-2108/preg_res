import 'package:flutter/material.dart';

class Usuario {
  int id;
  String nombre;
  String apellido;
  String email;
  String profileImage;
  int puntaje;
  int posAnual;
  int posMensual;
  int preguntas;
  int respuestas;

  Usuario({
    @required this.id,
    @required this.nombre,
    @required this.apellido,
    @required this.email,
    @required this.profileImage,
    @required this.puntaje,
    @required this.posAnual,
    @required this.posMensual,
    @required this.preguntas,
    @required this.respuestas,
  });
}

//  ACA TENGO QUE HACER LA CONSULTA AL BACKEND
bool iniciarSesionUsuario(String user, String password) {
  return true;
}

//  ACA TENGO QUE REGISTRAR AL USUARIO
//FIJARSE BIEN QUE VA A SER LO QUE SE VA A DEVOLVER
bool registrarUsuario(Map<String, String> datos) {
  return true;
}
