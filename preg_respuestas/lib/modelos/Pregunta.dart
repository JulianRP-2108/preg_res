import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Pregunta {
  Pregunta(
      {@required this.titulo,
      @required this.descripcion,
      this.palabrasClave,
      this.foto,
      this.id,
      this.votos,
      this.idAutor,
      this.fotoArchivo});

  String titulo;
  String foto;
  File fotoArchivo;
  List<dynamic> palabrasClave; //ESTO SOLO LO HAGO PARA COMPATIBILIDAD CON BD
  String descripcion;
  String id;
  DocumentReference idAutor;
  int votos;

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
        'votos': 0
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
}
