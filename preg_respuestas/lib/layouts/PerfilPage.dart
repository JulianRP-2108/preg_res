import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:preg_respuestas/layouts/ConfiguracionPage.dart';
import 'package:preg_respuestas/modelos/Usuario.dart';

class PerfilPage extends StatefulWidget {
  Usuario usuario = Usuario(
    id: 1,
    nombre: "Julian",
    apellido: "Rodriguez Petz",
    email: "rodriguezpetzjulian@gmail.com",
    profileImage:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    posAnual: 250,
    posMensual: 12,
    preguntas: 20,
    puntaje: 350,
    respuestas: 25,
  );
  //PerfilPage({@required this.usuario});

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  TextStyle subtitulo = TextStyle(
      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {}
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Perfil",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25.0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
        child: ListView(
          children: [
            _encabezado(context),
            Divider(
              color: Colors.black,
            ),
            _resumen(context),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 10.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: Text(
                  "Configuracion",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  pushNewScreen(context, screen: ConfiguracionPage());
                },
                color: Color(0xff4c79c3),
              ),
            )
          ],
        ),
      ),
    );
  }

  _encabezado(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return cambiarFoto(context);
                    });
              },
              child: CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(widget.usuario.profileImage),
              ),
            ),
          ),
          Expanded(
              child: Text(
            widget.usuario.nombre + " " + widget.usuario.apellido,
            style: this.subtitulo,
          )),
        ],
      ),
    );
  }

  _resumen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.usuario.email),
          Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
            child: Text(
              "Resumen:",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Puntaje: ",
                style: this.subtitulo,
              ),
              Text("250 Ptos")
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Posicion Anual: ",
                style: this.subtitulo,
              ),
              Text("350º Lugar")
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Posicion Mensual: ",
                style: this.subtitulo,
              ),
              Text("12º Lugar")
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Preguntas: ",
                style: this.subtitulo,
              ),
              Text(
                "200",
                overflow: TextOverflow.fade,
              )
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Respuestas: ",
                style: this.subtitulo,
              ),
              Text("25")
            ],
          ),
        ],
      ),
    );
  }

  AlertDialog cambiarFoto(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      title: Text("Editar foto"),
      content: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                color: Colors.indigo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                onPressed: () {
                  print("tomar foto");
                },
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 30.0,
                )),
            RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: Colors.indigo,
                onPressed: () {
                  print("Seleccionar de galeria");
                },
                child: Icon(
                  Icons.photo,
                  color: Colors.white,
                  size: 30.0,
                )),
          ],
        ),
      ),
      actions: [
        RaisedButton(
            padding: EdgeInsets.all(12.0),
            color: Colors.indigo,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
