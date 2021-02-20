import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:preg_respuestas/modelos/Usuario.dart';

class Pregunta {
  Pregunta(
      {@required this.titulo,
      @required this.descripcion,
      this.palabrasClave,
      this.foto,
      this.id,
      this.cantVotos,
      this.cantReportes,
      this.idAutor,
      this.fotoArchivo});

  String titulo;
  String foto;
  File fotoArchivo;
  List<dynamic> palabrasClave; //ESTO SOLO LO HAGO PARA COMPATIBILIDAD CON BD
  String descripcion;
  String id;
  DocumentReference idAutor;
  int cantVotos;
  int cantReportes;

  static Future<bool> postPregunta(Pregunta preg) async {
    //PRIMERO CREAR UNA REFERENCIA AL DOCUMENTO QUE VA A DIRECCIONAR LA IMAGEN
    String imageUrl;
    if (preg.fotoArchivo != null) {
      imageUrl = await uploadFile(preg.fotoArchivo);
      if (imageUrl == null) {
        return false;
      }
    } else {
      imageUrl = "";
    }

    //SUBIR EL RESTO DEL DOCUMENTO
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      await FirebaseFirestore.instance.collection('preguntas').add({
        'titulo': preg.titulo,
        'foto': imageUrl,
        'palabrasClave': preg.palabrasClave,
        'descripcion': preg.descripcion,
        'idAutor': preg.idAutor,
        'cantVotos': 0,
        'cantReportes': 0
      });
    } catch (e) {
      print(e);
      return false;
    }
    print("Pregunta subida totalmente");
    return true;
  }

  static Future<String> uploadFile(File _image) async {
    String resultado;
    String path = _image.path.split('/').last;
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('fotosPregunta/' + path);
      UploadTask uploadTask = storageReference.putFile(_image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      resultado = await taskSnapshot.ref.getDownloadURL();
      print("Listo, el resultado es: {$resultado}");
    } catch (e) {
      print("Ocurrio un error subiendo la foto");
      print(e);
    }
    return resultado;
  }

  //TODO: TENGOQ QUE ELIMINAR EL ARCHIVO DEL STORAGE TAMBIEN
  static Future<bool> eliminarPregunta(
      String idPregunta, DocumentReference idAutor) async {
    try {
      FirebaseFirestore.instance
          .collection('preguntas')
          .doc(idPregunta)
          .delete()
          .then((value) {
        print("Pregunta eliminada desde preguntas");
      });
    } catch (e) {
      print("Ocurrio un error en eliminarPregunta");
      return false;
    }
    return true;
  }

  //tengo que aumentar en 1 los votos a la pregunta
  //tengo que agregar la referencia de la pregunta al arreglo del usuario logueado
  static Future<bool> votarPregunta(Pregunta pregunta) async {
    try {
      await FirebaseFirestore.instance
          .collection('preguntas')
          .doc(pregunta.id)
          .update({'cantVotos': pregunta.cantVotos + 1});
      //.set({'cantVotos': pregunta.cantVotos + 1});
      DocumentReference referenciaPregunta =
          FirebaseFirestore.instance.doc('/preguntas/' + pregunta.id);
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        'preguntasVotadas': FieldValue.arrayUnion([referenciaPregunta])
      });
      var votadas = Usuario.getPreguntasVotadas();
      votadas.add(referenciaPregunta);
      Usuario.setPreguntasVotadas(votadas);
    } catch (e) {
      print("Error al likear pregunta");
      print(e);
      return false;
    }
    return true;
  }

  //tengo que disminuir en 1 si es mayor a 0 los votos a la pregunta
  //tengo que quitar la referencia de la pregunta al arreglo del usuario logueado
  static Future<bool> removeVotePregunta(Pregunta pregunta) async {
    try {
      if (pregunta.cantVotos > 0) {
        await FirebaseFirestore.instance
            .collection('preguntas')
            .doc(pregunta.id)
            .update({'cantVotos': pregunta.cantVotos - 1});
      }
      DocumentReference referenciaPregunta =
          FirebaseFirestore.instance.doc('/preguntas/' + pregunta.id);
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        'preguntasVotadas': FieldValue.arrayRemove([referenciaPregunta])
      });
      var votadas = Usuario.getPreguntasVotadas();
      votadas.remove(referenciaPregunta);
      Usuario.setPreguntasVotadas(votadas);
    } catch (e) {
      print("Error al quitar voto pregunta");
      print(e);
      return false;
    }
    print("Voto quitado correctamente");
    return true;
  }
}
