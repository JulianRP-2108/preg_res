import 'package:flutter/material.dart';

class Pregunta {
  Pregunta(
      {@required this.titulo, @required this.descripcion, this.palabrasClave});

  String titulo;
  List<String> fotos;
  List<String> palabrasClave;
  String descripcion;
  int id;
  int idUsuario;
}
