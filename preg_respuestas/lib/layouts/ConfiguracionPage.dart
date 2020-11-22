import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:preg_respuestas/modelos/AuthHelper.dart';
import 'package:provider/provider.dart';

//TODO: TENGO QUE RECIBIR AL USUARIO TAMBIEN
class ConfiguracionPage extends StatefulWidget {
  @override
  _ConfiguracionPageState createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Configuracion",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.announcement_sharp,
                color: Colors.indigo,
              ),
              title: Text("Contraseña"),
              trailing: Text("*******"),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.announcement_sharp,
                color: Colors.indigo,
              ),
              title: Text("Tema"),
              trailing: Text("Claro"),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.announcement_sharp,
                color: Colors.indigo,
              ),
              title: Text("Texto a voz"),
              trailing: Text("Desactivado"),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.announcement_sharp,
                color: Colors.indigo,
              ),
              title: Text("Cerrar sesion"),
              onTap: () {
                AuthHelper.logOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
