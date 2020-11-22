import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:preg_respuestas/modelos/AuthHelper.dart';
import 'package:preg_respuestas/modelos/Usuario.dart';
import 'package:preg_respuestas/widgets/alertaNotificacion.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';

class IniciarSesion extends StatefulWidget {
  @override
  _IniciarSesionState createState() => _IniciarSesionState();
}

class _IniciarSesionState extends State<IniciarSesion> {
  final FocusNode _usuario = new FocusNode();
  final FocusNode _password = new FocusNode();

  final _usuarioController = new TextEditingController();
  final _passwordController = new TextEditingController();

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  bool checkedValue = false;

  @override
  void initState() {
    super.initState();
    this.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            this.isLoading = false;
            dispose();
            return HomePage();
          } else {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  elevation: 0.0,
                  centerTitle: true,
                  title: Text(
                    "Iniciar Sesion",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.transparent),
              body: Container(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.5, 1.0],
                        colors: [Color(0xff004e92), Color(0xff000428)])),
                child: this.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : ListView(
                        children: [
                          //_encabezado(context), //Texto decorado de iniciar sesion
                          _formulario(
                              context), //usuario, contraseña, boton aceptar
                          _extras(
                              context), //Olvidaste contraseña? o ir a registrarse
                        ],
                      ),
              ),
            );
          }
        });
  }

  _encabezado(BuildContext context) {
    return Text(
      "Iniciar Sesion",
      style: TextStyle(
          color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
    );
  }

  _formulario(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                focusNode: _usuario,
                controller: _usuarioController,
                onFieldSubmitted: (term) {
                  cambiarFocoCampo(context, _usuario, _password);
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'Ej: usuario@email.com',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo no puede estar vacio';
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Contraseña",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                focusNode: _password,
                controller: _passwordController,
                onFieldSubmitted: (term) {
                  //cambiarFocoCampo(context, _titulo, _descripcion);
                },
                decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white)),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo no puede estar vacio';
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "¿Olvidaste la contraseña?",
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Recuperar",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: CheckboxListTile(
                    dense: true,
                    checkColor: Colors.white,
                    title: Text(
                      "Recordarme",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: checkedValue,
                    onChanged: (value) {
                      setState(() {
                        checkedValue = value;
                      });
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Center(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print("Apretaste el boton");
                        setState(() {
                          this.isLoading = true;
                        });
                        try {
                          final user = await AuthHelper.signInWithEmail(
                              email: _usuarioController.text,
                              password: _passwordController.text);
                          if (user != null) {
                            print("Iniciaste sesion correctamente");
                          }
                        } on FirebaseAuthException catch (e) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertaNotificacion(
                                  titulo: "Error al iniciar sesion",
                                  notificacion: e.message,
                                );
                              });
                          setState(() {
                            this.isLoading = false;
                          });
                        }
                      }
                    },
                    color: Colors.white,
                    child: Text(
                      "Iniciar Sesion",
                      style: TextStyle(color: Colors.blue[800]),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  _extras(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "¿No tienes cuenta?",
                  style: TextStyle(color: Colors.white),
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("/registro");
                    },
                    child: Text(
                      "Registrate",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void cambiarFocoCampo(
      BuildContext context, FocusNode focoActual, FocusNode focoSiguiente) {
    focoActual.unfocus();
    FocusScope.of(context).requestFocus(focoSiguiente);
  }

  @override
  void dispose() {
    _usuarioController.clear();
    _passwordController.clear();
    super.dispose();
  }
}
