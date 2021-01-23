import 'dart:io';

import 'package:flutter/material.dart';

class Pregunta {
  Pregunta(
      {@required this.titulo,
      @required this.descripcion,
      this.palabrasClave,
      this.foto,
      this.id,
      this.votos,
      this.idUsuario,
      this.fotoArchivo});

  String titulo;
  String foto;
  File fotoArchivo;
  List<dynamic> palabrasClave; //ESTO SOLO LO HAGO PARA COMPATIBILIDAD CON BD
  String descripcion;
  String id;
  String idUsuario;
  int votos;

  Future<bool> postPregunta(Pregunta preg) async {
    return false;
  }
}
