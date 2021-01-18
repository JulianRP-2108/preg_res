import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<bool> respuestaPost(Respuesta respuesta) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentReference referenciaPregunta =
          db.doc('/preguntas/' + respuesta.idPregunta);
      DocumentReference referenciaAutor =
          db.doc('/usuarios/' + respuesta.idAutor);
      await FirebaseFirestore.instance.collection('respuestas').add({
        'descripcion': respuesta.descripcion,
        'foto': respuesta.foto,
        'idPregunta': referenciaPregunta,
        'idAutor': referenciaAutor,
        //'fecha' : TODO: SACAR LA FECHA ACTUAL
        'votos': 0
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
