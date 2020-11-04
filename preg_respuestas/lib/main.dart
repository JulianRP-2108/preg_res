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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization, //ESTO ES PARA LA INICIALIZACION DE FIREBASE
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorLayout();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<LoginState>(
                create: (_) => LoginState(),
                lazy: false,
              )
            ],
            child: MaterialApp(
              title: 'ParaPreguntar',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              routes: {
                "/": (BuildContext context) {
                  //var state = Provider.of<LoginState>(context);

                  if (context.watch<LoginState>().isLoggedIn()) {
                    return HomePage();
                  } else {
                    return IniciarSesion();
                  }
                },
                "/iniciarSesion": (BuildContext context) => IniciarSesion(),
                "/registro": (BuildContext context) => Registro(),
                '/homePage': (BuildContext context) => HomePage(),
              },
            ),
          );
        }
        return SplashScreen();
      },
    );
  }
}
