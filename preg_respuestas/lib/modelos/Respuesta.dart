import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  DocumentReference idPregunta;
  DocumentReference idAutor;
  int votos;

  static Future<bool> respuestaPost(Respuesta respuesta) async {
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
      await FirebaseFirestore.instance.collection('respuestas').add({
        'descripcion': respuesta.descripcion,
        'foto': imageUrl,
        'idPregunta': respuesta.idPregunta,
        'idAutor': respuesta.idAutor,
        'votos': 0
      });
    } catch (e) {
      return false;
    }
    print("Respuesta subida totalmente");
    return true;
  }

  static Future<String> uploadFile(File _image) async {
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

//FALTA ELIMINAR LA FOTO DE LA RESPUESTA EN CASO DE TENERLA
  static Future<bool> eliminarRespuesta(Respuesta respuesta) async {
    try {
      print("El id de la respuesta es: ");
      print(respuesta.id);
      print("EL id del usuario es: ");
      print(FirebaseAuth.instance.currentUser.uid);
      FirebaseFirestore.instance
          .collection('respuestas')
          .doc(respuesta.id)
          .delete()
          .then((value) {
        print("respuesta eliminada desde preguntas");
      });
    } catch (e) {
      print("Ocurrio un error al eliminar respuesta");
      return false;
    }
    return true;
  }
}
