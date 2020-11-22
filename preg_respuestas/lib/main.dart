import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:preg_respuestas/layouts/ErrorLayout.dart';
import 'package:preg_respuestas/layouts/HomePage.dart';
import 'package:preg_respuestas/layouts/IniciarSesion.dart';
import 'package:preg_respuestas/layouts/PreguntaPage.dart';
import 'package:preg_respuestas/layouts/Registro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:preg_respuestas/modelos/login_state.dart';
import 'package:provider/provider.dart';

import 'layouts/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParaPreguntar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IniciarSesion(),
      routes: {
        "/registro": (BuildContext context) => Registro(),
        "/iniciarSesion": (BuildContext context) => IniciarSesion(),
      },
    );
  }
}
