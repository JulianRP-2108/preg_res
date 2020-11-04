import 'package:flutter/material.dart';
import 'package:preg_respuestas/modelos/Usuario.dart';
import 'package:preg_respuestas/modelos/login_state.dart';
import 'package:preg_respuestas/widgets/alertaNotificacion.dart';
import 'package:provider/provider.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final FocusNode _nombre = new FocusNode();
  final FocusNode _apellido = new FocusNode();
  final FocusNode _email = new FocusNode();
  final FocusNode _password = new FocusNode();
  final FocusNode _password2 = new FocusNode();

  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  final _registroFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Registrarse",
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.5, 1.0],
                  colors: [Color(0xff004e92), Color(0xff000428)])),
          child: Consumer<LoginState>(
            builder: (BuildContext context, LoginState value, Widget child) {
              if (value.isLoading()) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                );
              } else {
                return child;
              }
            },
            child: ListView(
              children: [
                //_encabezado(context),
                _formulario(context),
                _extras(context),
              ],
            ),
          )),
    );
  }

  _encabezado(BuildContext context) {
    return Text(
      "Registrarse",
      style: TextStyle(
          color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
    );
  }

  _formulario(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Form(
        key: _registroFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nombre",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              focusNode: _nombre,
              controller: _nombreController,
              onFieldSubmitted: (term) {
                cambiarFocoCampo(context, _nombre, _apellido);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Nombre',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Este campo no puede estar vacio';
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Apellido",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              focusNode: _apellido,
              controller: _apellidoController,
              onFieldSubmitted: (term) {
                cambiarFocoCampo(context, _apellido, _password);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Apellido',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Este campo no puede estar vacio';
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Email",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              focusNode: _email,
              controller: _emailController,
              onFieldSubmitted: (term) {
                cambiarFocoCampo(context, _email, _password);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Ej: tuEmail@mail.com',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Este campo no puede estar vacio';
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Contraseña",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              focusNode: _password,
              obscureText: true,
              controller: _passwordController,
              onFieldSubmitted: (term) {
                cambiarFocoCampo(context, _password, _password2);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Ej: 1234 o mejor',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Este campo no puede estar vacio';
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Repetir contraseña",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              focusNode: _password2,
              obscureText: true,
              controller: _password2Controller,
              onFieldSubmitted: (term) {},
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Ej: 1234 o mejor',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Este campo no puede estar vacio';
                }
                if (_passwordController.text != _password2Controller.text) {
                  return "Las contraseñas no coinciden";
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Center(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  onPressed: () async {
                    if (_registroFormKey.currentState.validate()) {
                      Map<String, String> datosUsuario = {
                        'nombre': _nombreController.text,
                        'apellido': _apellidoController.text,
                        'email': _emailController.text,
                        'password': _passwordController.text,
                      };
                      context
                          .read<LoginState>()
                          .registerUser(datosUsuario)
                          .then((resultado) {
                        if (!resultado['registrado']) {
                          showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertaNotificacion(
                                  titulo: "Error al registrarse",
                                  notificacion: resultado['mensaje'],
                                );
                              });
                        } else {
                          Navigator.of(context)
                              .pushReplacementNamed('/homePage');
                        }
                      });
                    }
                  },
                  color: Colors.white,
                  child: Text(
                    "Registrarse",
                    style: TextStyle(color: Colors.blue[800]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
                  "¿Ya tienes cuenta?",
                  style: TextStyle(color: Colors.white),
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed("/iniciarSesion");
                    },
                    child: Text(
                      "Inicia Sesion",
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
}
