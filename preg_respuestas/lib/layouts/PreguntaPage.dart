import 'package:flutter/material.dart';
import 'package:preg_respuestas/modelos/Pregunta.dart';
import 'package:preg_respuestas/widgets/alertaConfirmacion.dart';

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
        backgroundColor: Color(0xff004e92),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "AyudaPar", //CAMBIAR ETE NOMBRE NEFASTo
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: Container(), //esto es solo para borrar la flecha hacia atras
      ),
      body: ListView(
        children: [
          _encabezado(
              context), //ACA IRIA LA PREGUNTA EN SI CON LAS PALABRAS CLAVES
          _detalle(context), //ACA IRIA LA DESCRIPCION, DESPUES LA FOTO
          _demasDatos(context),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            child: Text(
              "Respuestas: ",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          _respuestas(
              context), //ACA IRIAN LAS RESPUESTAS EN CASO DE QUE LAS HUBIERA
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

  Widget _detalle(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Divider(
            color: Colors.black,
          ),
          //RESOLVER EL TEMA DE LOS SALTOS DE LINEA
          Text(
            "Este fin de semana tuvo lugar la Feria de Artesanos en los terrenos del ferrocarril, en el lugar estuvieron ubicados artesanos y artesanas de nuestra ciudad y de otras localidades pampeanas, con el fin de continuar ofreciendo espacios de comercialización y difusión para el sector.\n La Dirección de Educación y Cultura junto al Consejo Municipal de Artesanos, realizó una nueva Feria de Artesanos, ayer desde las 14 hasta las 18 horas. La actividad tenía previsto continuar desarrollándose hoy, pero debió suspenderse por las condiciones climáticas",
            style: TextStyle(),
            textAlign: TextAlign.justify,
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            elevation: 10.0,
            //espacio para foto
            child: Image.network(
                "https://images.twinkl.co.uk/tr/image/upload/illustation/Question-Marks.png"),
          )
        ],
      ),
    );
  }

  //Aca, para cada respuesta que se tenga hay que repetir el widget
  Widget _respuestas(BuildContext context) {
    List<Widget> respuestas = new List<Widget>();
    for (int i = 0; i < 10; i++) {
      respuestas.add(Column(
        children: [
          Text(
            "Este fin de semana tuvo lugar la Feria de Artesanos en los terrenos del ferrocarril, en el lugar estuvieron ubicados artesanos y artesanas de nuestra ciudad y de otras localidades pampeanas, con el fin de continuar ofreciendo espacios de comercialización y difusión para el sector.\n La Dirección de Educación y Cultura junto al Consejo Municipal de Artesanos, realizó una nueva Feria de Artesanos, ayer desde las 14 hasta las 18 horas. La actividad tenía previsto continuar desarrollándose hoy, pero debió suspenderse por las condiciones climáticas",
            style: TextStyle(),
            textAlign: TextAlign.justify,
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            elevation: 10.0,
            //espacio para foto
            child: Image.network(
                "https://images.twinkl.co.uk/tr/image/upload/illustation/Question-Marks.png"),
          ),
          _demasDatos(
              context), //TODO: LLAMAR A ESTA FUNCION CON LOS DATOS CORRESPONDIENTES
          Divider(
            color: Colors.black,
          ),
        ],
      ));
    }
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(children: respuestas),
    );
  }

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

  //username, idpregunta o id respuesta, tipo si es pregunta o respuesta
  Widget _demasDatos(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "@Username_23sadfgfgjhhgfdsfkkjhgfdshgfdkjhgffdkjhgf",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "(25)",
                    ),
                    IconButton(
                        icon: Icon(Icons.volunteer_activism),
                        onPressed: () {
                          print("pregunta votada");
                        }),
                    IconButton(
                        icon: Icon(Icons.report_gmailerrorred_rounded),
                        onPressed: () {
                          print("Pregunta reportada");
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return ALertaConfirmacion(
                                    pregunta:
                                        "¿Desea reportar la pregunta (IDPregunta)?",
                                    titulo: "Reporte");
                              });
                        })
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
