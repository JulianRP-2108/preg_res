import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:preg_respuestas/layouts/ErrorLayout.dart';
import 'package:preg_respuestas/layouts/HomePage.dart';
import 'package:preg_respuestas/layouts/IniciarSesion.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Autenticar, si no autentico mandarlo al iniciar sesion, sino mandarlo al home

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return HomePage();
    } else {
      return IniciarSesion();
    }
  }
}

//@override
//Widget build(BuildContext context) {
//  return Scaffold(
//    body: Container(
//      decoration: BoxDecoration(
//          gradient: LinearGradient(
//        begin: Alignment.topCenter,
//        end: Alignment.bottomCenter,
//        colors: [Color(0xff004e92), Color(0xff000428)],
//        stops: [0.5, 1.0],
//      )),
//      child: Center(
//        child: Text(
//          "ParaPreguntar",
//          style: TextStyle(color: Colors.white, fontSize: 28),
//        ),
//      ),
//    ),
//  );
//}
