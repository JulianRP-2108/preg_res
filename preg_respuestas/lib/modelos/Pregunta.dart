import 'package:flutter/material.dart';

class Pregunta {
  Pregunta(
      {@required this.titulo,
      @required this.descripcion,
      this.palabrasClave,
      this.foto,
      this.id,
      this.votos,
      this.idUsuario});

  String titulo;
  String foto;
  List<dynamic> palabrasClave; //ESTO SOLO LO HAGO PARA COMPATIBILIDAD CON BD
  String descripcion;
  String id;
  String idUsuario;
  int votos;
}
