import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:preg_respuestas/modelos/Pregunta.dart';
import 'package:preg_respuestas/modelos/Respuesta.dart';
import 'package:preg_respuestas/widgets/alertaConfirmacion.dart';

/* 

  ESTA PANTALLA TIENE QUE RECIBIR LA PREGUNTA ENTERA,
  Si el id del autor de la pregunta es el mismo que el id del usuario dejarlo eliminar

 */

// ignore: must_be_immutable
class PreguntaPage extends StatefulWidget {
  Pregunta pregunta;

  PreguntaPage({@required this.pregunta});

  @override
  _PreguntaPageState createState() => _PreguntaPageState();
}

class _PreguntaPageState extends State<PreguntaPage> {
  List<Respuesta> _respuestasData = new List<Respuesta>();
  String autorPregunta;
  ScrollController controladorScroll = new ScrollController();

  File _image;
  final picker = ImagePicker();

  TextEditingController controladorDescripcion = new TextEditingController();

  @override
  void initState() {
    super.initState();
    var referencia = FirebaseFirestore.instance
        .collection('preguntas')
        .doc(widget.pregunta.id);
    FirebaseFirestore.instance
        .collection('respuestas')
        .where('idPregunta', isEqualTo: referencia)
        .orderBy('votos', descending: true)
        .get()
        .catchError((e) => print(e))
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        this._respuestasData.add(
              Respuesta(
                  descripcion: value.docs[i]['descripcion'],
                  idAutor: value.docs[i]['idAutor'].toString(),
                  idPregunta: value.docs[i]['idPregunta'].toString(),
                  foto: value.docs[i]["foto"],
                  votos: value.docs[i]['votos']),
            );
      }
      print("La cantidad de respuestas es: ${this._respuestasData.length}");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        backgroundColor: Color(0xff004e92),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "ParAyudar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: Container(), //esto es solo para borrar la flecha hacia atras
      ),
      body: ListView(
        controller: this.controladorScroll,
        children: [
          _encabezado(context),
          _detalle(context),
          _demasDatos(
            context,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Align(
              alignment: Alignment.center,
              child: RaisedButton(
                color: Color(0xffff8f00),
                onPressed: () {
                  Timer(Duration(milliseconds: 500), () {
                    this.controladorScroll.animateTo(
                        this.controladorScroll.position.viewportDimension +
                            this.controladorScroll.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                  });
                },
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Responder"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            child: Text(
              "Respuestas: ",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          _respuestas(context),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 8.0),
            child: Text(
              "Ayuda a tu compañero: ",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          _formResponder(context)
        ],
      ),
    );
  }

  _encabezado(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(
            widget.pregunta.titulo,
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Container(
              height: 50.0,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _getPalabrasClaves()))
        ],
      ),
    );
  }

  Widget _detalle(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.pregunta.descripcion,
              style: TextStyle(),
              textAlign: TextAlign.justify,
            ),
          ),
          Card(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              elevation: 10.0,
              //espacio para foto

              child: widget.pregunta.foto != ""
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Image.network(
                        widget.pregunta.foto,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container())
        ],
      ),
    );
  }

  //Aca, para cada respuesta que se tenga hay que repetir el widget
  Widget _respuestas(BuildContext context) {
    List<Widget> respuestasWidget = new List<Widget>();
    for (int i = 0; i < this._respuestasData.length; i++) {
      respuestasWidget.add(Column(
        children: [
          Text(
            this._respuestasData[i].descripcion,
            style: TextStyle(),
            textAlign: TextAlign.justify,
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            elevation: 10.0,
            //espacio para foto
            child: this._respuestasData[i].foto != ""
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.network(
                      this._respuestasData[i].foto,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(),
          ),
          _demasDatosRespuestas(context, i),
          Divider(
            color: Colors.black,
          ),
        ],
      ));
    }
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(children: respuestasWidget),
    );
  }

  List<Widget> _getPalabrasClaves() {
    List<Widget> chips = new List<Widget>();
    if (widget.pregunta.palabrasClave != null) {
      for (var clave in widget.pregunta.palabrasClave) {
        chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.0),
          child: Chip(
            label: Text(
              clave,
              style: TextStyle(fontSize: 11.0),
            ),
            backgroundColor: Colors.grey[300],
          ),
        ));
      }
    }
    return chips;
  }

  Widget _demasDatos(BuildContext context) {
    DocumentReference autorReference =
        FirebaseFirestore.instance.doc(widget.pregunta.idAutor);
    String path = autorReference.path.split('/')[1];
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(path)
        .get()
        .catchError((e) => print(e))
        .then((usuario) {
      if (usuario != null) {
        setState(() {
          autorPregunta = usuario.get('nombre') + ' ' + usuario.get('apellido');
        });
      } else {
        print("Usuario no encontrado");
      }
    });

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  autorPregunta == null ? "" : autorPregunta,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "(" + widget.pregunta.votos.toString() + ")",
                    ),
                    path == FirebaseAuth.instance.currentUser.uid
                        ? IconButton(
                            icon: Icon(Icons.highlight_remove_sharp),
                            color: Colors.red[300],
                            onPressed: () {
                              print("Eliminando pregunta");
                            })
                        : Container(),
                    IconButton(
                        icon: Icon(Icons.volunteer_activism),
                        onPressed: () {
                          print("pregunta votada");
                        }),
                    IconButton(
                        icon: Icon(Icons.report_gmailerrorred_rounded),
                        onPressed: () {
                          print("Pregunta reportada");
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return ALertaConfirmacion(
                                    pregunta:
                                        "¿Desea reportar la pregunta (IDPregunta)?",
                                    titulo: "Reporte");
                              });
                        })
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  //username, idpregunta o id respuesta, tipo si es pregunta o respuesta
  Widget _demasDatosRespuestas(BuildContext context, int index) {
    print(this._respuestasData[index].idAutor);
    String path =
        this._respuestasData[index].idAutor.split('/')[1].split(')')[0];
    print(path);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("usuarios")
                      .doc(path)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Text("");
                    }
                    return Text(
                      snapshot.data.get('nombre') +
                          ' ' +
                          snapshot.data.get('apellido'),
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "(${this._respuestasData[index].votos})",
                    ),
                    IconButton(
                        icon: Icon(Icons.volunteer_activism),
                        onPressed: () {
                          print("pregunta votada");
                        }),
                    IconButton(
                        icon: Icon(Icons.report_gmailerrorred_rounded),
                        onPressed: () {
                          print("Pregunta reportada");
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return ALertaConfirmacion(
                                    pregunta:
                                        "¿Desea reportar la pregunta (IDPregunta)?",
                                    titulo: "Reporte");
                              });
                        })
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  //SOLO TIENE QUE TENER FOTO Y DESCRIPCION
  //LA FECHA, PALABRAS CLAVE, ID DE LA PREGUNTA SE SACA DE LA PREGUNTA RECIBIDA
  //EL ID DEL AUTOR SERA DEL USUARIO LOGUEADO
  Widget _formResponder(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 8.0),
        child: SingleChildScrollView(
            child: Form(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                maxLines: 8,
                controller: this.controladorDescripcion,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  hintText: 'Responde de forma clara y respetuosa',
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
                    onPressed: () {
                      //TODO: FALTA VALIDAR EL FORM
                      final String uid = FirebaseAuth.instance.currentUser.uid;
                      Respuesta respuesta = new Respuesta(
                          descripcion: this.controladorDescripcion.text,
                          idAutor: uid,
                          idPregunta: widget.pregunta.id,
                          fotoArchivo: _image);
                      try {
                        respuesta.respuestaPost(respuesta);
                        print("La respuesta se hizo correctamente");
                      } catch (e) {
                        print("Hubo un error");
                        print(e);
                      }
                    },
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text("Realizar respuesta"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                ),
              )
            ]))));
  }

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
}
