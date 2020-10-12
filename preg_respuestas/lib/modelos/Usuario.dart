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
