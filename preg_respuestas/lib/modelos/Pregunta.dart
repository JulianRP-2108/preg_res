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
  String idAutor;
  int votos;

  Future<bool> postPregunta(Pregunta preg) async {
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
      DocumentReference referenciaAutor = db.doc('/usuarios/' + preg.idAutor);
      await FirebaseFirestore.instance.collection('preguntas').add({
        'titulo': preg.titulo,
        'foto': imageUrl,
        'palabrasClave': preg.palabrasClave,
        'descripcion': preg.descripcion,
        'idAutor': referenciaAutor,
        'votos': 0
      });
    } catch (e) {
      print(e);
      return false;
    }
    print("Pregunta subida totalmente");
    return true;
  }

  Future<String> uploadFile(File _image) async {
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
}
