import 'package:flutter/material.dart';

class NuevaPregunta extends StatefulWidget {
  @override
  _NuevaPreguntaState createState() => _NuevaPreguntaState();
}

class _NuevaPreguntaState extends State<NuevaPregunta> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _titulo = FocusNode();
  final FocusNode _descripcion = FocusNode();
  final FocusNode _palabrasClave = FocusNode();

  final _tituloController = TextEditingController();
  final _clavesController = TextEditingController();
  final _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(
          "Nueva Pregunta",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
          margin: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
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
                  child: IconButton(
                    icon: Icon(
                      Icons.photo_camera_outlined,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      print("Sacando fotuli"); //MANEJAR EL TEMA DE LOS PERMISOS
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      color: Colors.greenAccent,
                      onPressed: () {
                        print("Pusheando pregunta");
                      },
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text("Realizar pregunta"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                  ),
                )
              ],
            )),
          )),
    );
  }

  void cambiarFocoCampo(
      BuildContext context, FocusNode focoActual, FocusNode focoSiguiente) {
    focoActual.unfocus();
    FocusScope.of(context).requestFocus(focoSiguiente);
  }
}
