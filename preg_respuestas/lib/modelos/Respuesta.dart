import 'package:flutter/material.dart';

class Respuesta {
  Respuesta(
      {@required this.descripcion,
      @required this.idAutor,
      @required this.idPregunta,
      this.foto,
      this.id,
      this.votos});

  String descripcion;
  String foto;
  String id;
  String idPregunta;
  String idAutor;
  int votos;
}
