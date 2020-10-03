import 'package:flutter/material.dart';
import 'package:preg_respuestas/modelos/Pregunta.dart';

/* 

  ESTA PANTALLA TIENE QUE RECIBIR LA PREGUNTA ENTERA

 */

// ignore: must_be_immutable
class PreguntaPage extends StatefulWidget {
  Pregunta pregunta = new Pregunta(
      titulo: "¿Como calcular area de un ciruclo?",
      descripcion: "Esta es una descripcion cualquiera",
      palabrasClave: [
        "matematica",
        "algebra",
        "circulos",
        "geometria",
        "geometria",
        "geometria",
        "geometria",
        "geometria"
      ]);

  //PreguntaPage({@required this.pregunta});

  @override
  _PreguntaPageState createState() => _PreguntaPageState();
}

class _PreguntaPageState extends State<PreguntaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "AyudaPar", //CAMBIAR ETE NOMBRE NEFASTo
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: Container(), //esto es solo para borrar la flecha hacia atras
      ),
      body: ListView(
        children: [
          _encabezado(
              context), //ACA IRIA LA PREGUNTA EN SI CON LAS PALABRAS CLAVES
          //_detalle(context), //ACA IRIA LA DESCRIPCION, DESPUES LA FOTO
          //_respuestas(
          //    context), //ACA IRIAN LAS RESPUESTAS EN CASO DE QUE LAS HUBIERA
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

  _detalle(BuildContext context) {}

  _respuestas(BuildContext context) {}

  List<Widget> _getPalabrasClaves() {
    List<Widget> chips = new List<Widget>();
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

    return chips;
  }
}
