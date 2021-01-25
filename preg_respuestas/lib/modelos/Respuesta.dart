import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Respuesta {
  Respuesta(
      {@required this.descripcion,
      @required this.idAutor,
      @required this.idPregunta,
      this.foto,
      this.fotoArchivo,
      this.id,
      this.votos});

  String descripcion;
  String foto;
  File fotoArchivo;
  String id;
  String idPregunta;
  String idAutor;
  int votos;

  Future<bool> respuestaPost(Respuesta respuesta) async {
    //PRIMERO CREAR UNA REFERENCIA AL DOCUMENTO QUE VA A DIRECCIONAR LA IMAGEN
    String imageUrl;
    if (respuesta.fotoArchivo != null) {
      imageUrl = await uploadFile(respuesta.fotoArchivo);
      if (imageUrl == null) {
        return false;
      }
    } else {
      imageUrl = "";
    }

    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentReference referenciaPregunta =
          db.doc('/preguntas/' + respuesta.idPregunta);
      DocumentReference referenciaAutor =
          db.doc('/usuarios/' + respuesta.idAutor);
      await FirebaseFirestore.instance.collection('respuestas').add({
        'descripcion': respuesta.descripcion,
        'foto': imageUrl,
        'idPregunta': referenciaPregunta,
        'idAutor': referenciaAutor,
        'votos': 0
      });
    } catch (e) {
      return false;
    }
    print("Respuesta subida totalmente");
    return true;
  }

  Future<String> uploadFile(File _image) async {
    String resultado;
    String path = _image.path.split('/').last;
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('fotosRespuesta/' + path);
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
}
