import 'package:flutter/material.dart';
import 'package:preg_respuestas/layouts/HomePage.dart';
import 'package:preg_respuestas/layouts/IniciarSesion.dart';
import 'package:preg_respuestas/layouts/PreguntaPage.dart';
import 'package:preg_respuestas/layouts/Registro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      initialRoute: "iniciarSesion",
      routes: {
        "iniciarSesion": (BuildContext context) => IniciarSesion(),
        "registro": (BuildContext context) => Registro(),
        'homePage': (BuildContext context) => HomePage(),
      },
    );
  }
}
