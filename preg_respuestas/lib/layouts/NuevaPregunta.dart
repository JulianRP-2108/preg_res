import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:preg_respuestas/modelos/Pregunta.dart';
import 'package:preg_respuestas/widgets/alertaNotificacion.dart';

class NuevaPregunta extends StatefulWidget {
  @override
  _NuevaPreguntaState createState() => _NuevaPreguntaState();
}

class _NuevaPreguntaState extends State<NuevaPregunta> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _titulo = FocusNode();
  final FocusNode _descripcion = FocusNode();
  final FocusNode _palabrasClave = FocusNode();

  File _image;
  final picker = ImagePicker();

  List<String> _palabrasClaveList = new List<String>();

  final _tituloController = TextEditingController();
  final _clavesController = TextEditingController();
  final _descripcionController = TextEditingController();
  bool isloading = false;

  _imgFromCamera() async {
    final pickedfile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedfile != null) {
        this._image = File(pickedfile.path);
      } else {
        print("No se ha seleccionado ninguna imagen");
      }
    });
  }

  _imgFromGallery() async {
    final pickedfile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedfile != null) {
        this._image = File(pickedfile.path);
      } else {
        print("No se ha seleccionado ninguna imagen");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff004e92),
        title: Text(
          "Nueva Pregunta",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
          margin: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: _createForm(context),
          )),
    );
  }

  void cambiarFocoCampo(
      BuildContext context, FocusNode focoActual, FocusNode focoSiguiente) {
    focoActual.unfocus();
    FocusScope.of(context).requestFocus(focoSiguiente);
  }

  Widget palabrasClaveContainer(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Container(
            height: 50.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this._palabrasClaveList.length == 0
                    ? 1
                    : this._palabrasClaveList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (this._palabrasClaveList.length == 0) {
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Chip(
                      label: Text(
                        this._palabrasClaveList[index],
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.grey[200],
                    ),
                  );
                })));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeria'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camara'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _createForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                "Titulo",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              focusNode: _titulo,
              controller: _tituloController,
              onFieldSubmitted: (term) {
                cambiarFocoCampo(context, _titulo, _descripcion);
              },
              decoration: InputDecoration(
                hintText: 'Ej: ¿Cual es el area de un circulo?',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Este campo no puede estar vacio';
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                "Descripcion",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              focusNode: _descripcion,
              controller: _descripcionController,
              onFieldSubmitted: (term) {
                cambiarFocoCampo(context, _descripcion, _palabrasClave);
              },
              maxLines: 8,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'Describe con mas detalle tu consulta',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Este campo no puede estar vacio';
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                "Palabras clave",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              //TODO: AL TOCAR EL ESPACIO QUE SE HAGAN CHIPS SI ES QUE SE PUEDEN, SINO PONERLOS ABAJO
              focusNode: _palabrasClave,
              controller: _clavesController,
              onChanged: (frase) {
                if (frase.isEmpty) {
                  print("Entre al vacio");
                  this._palabrasClaveList.clear();
                }
                if (frase.endsWith(' ')) {
                  this._palabrasClaveList = frase.split(' ');
                  this
                      ._palabrasClaveList
                      .removeWhere((element) => element.length <= 3);
                  print("la lista completa es: ");
                  print(this._palabrasClaveList);
                }
                setState(() {});
              },
              onFieldSubmitted: (term) {
                //TODO: QUE HACER ACA? ESCONDER EL TECLADO PARA QUE SE VEA EL BOTON DE LAS FOTOS?
              },
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: 'Ej: Matematica, Geometría, Filosofía',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Este campo no puede estar vacio';
                }
              },
            ),
            palabrasClaveContainer(context),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                "Imagen (Opcional)",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 80,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: this._image == null
                  ? IconButton(
                      icon: Icon(
                        Icons.photo_camera_outlined,
                        color: Color(0xff004e92),
                      ),
                      onPressed: () {
                        _showPicker(context);
                      },
                    )
                  : GestureDetector(
                      onTap: () => _showPicker(context),
                      onLongPress: () {
                        setState(() {
                          this._image = null;
                        });
                      },
                      child: Image.file(
                        _image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Align(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Color(0xffff8f00),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        this.isloading = true;
                      });
                      Pregunta preg = new Pregunta(
                        titulo: this._tituloController.text,
                        descripcion: this._descripcionController.text,
                        palabrasClave: this._palabrasClaveList,
                        idAutor: FirebaseAuth.instance.currentUser.uid,
                        votos: 0,
                        foto: "",
                        fotoArchivo: this._image,
                        id: "",
                      );
                      bool isUp = await preg.postPregunta(preg);
                      setState(() {
                        this.isloading = false;
                      });
                      if (!isUp) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertaNotificacion(
                                titulo: "Error al preguntar",
                                notificacion: "Por favor, intente más tarde",
                              );
                            });
                      }
                    }
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text("Realizar pregunta"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            )
          ],
        ));
  }
}
