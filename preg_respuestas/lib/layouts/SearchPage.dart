import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:preg_respuestas/layouts/PreguntaPage.dart';
import 'package:preg_respuestas/modelos/Pregunta.dart';

import 'NuevaPregunta.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBarController<Pregunta> _searchBarController =
      SearchBarController();

  //ACA TENGO QUE PONER LAS 20 MAS RECIENTES O ALGUNA IMAGEN COPADA
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String _consulta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Preguntas",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: cuerpo(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffff8f00),
        child: Icon(
          Icons.question_answer_rounded,
          color: Colors.white,
        ),
        onPressed: () => pushNewScreen(
          context,
          screen: NuevaPregunta(),
          withNavBar: true,
        ),
      ),
    );
  }

  Future<List<Pregunta>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Pregunta(
          titulo: "¿Como calcular area de circulo?",
          descripcion: "descripcion");
    });
  }

  Widget cuerpo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        child: SearchBar<Pregunta>(
            iconActiveColor: Colors.blueAccent,
            onSearch: (query) {
              return getPreguntas(query);
            },
            cancellationWidget: Icon(Icons.cancel, color: Colors.black),
            searchBarController: _searchBarController,
            onItemFound: (Pregunta pregunta, int index) {
              return preguntaWidget(pregunta);
            }),
      ),
    );
  }

  //ESTA SERIA LA FUNCION QUE VA LLAMANDO AL API CADA VEZ QUE SE CAMBIA EL QUERY
  Future<List<Pregunta>> getPreguntas(String query) async {
    List<String> palabras = query.split(" ");

    List<Pregunta> preguntas = new List<Pregunta>();
    var porTitulo = await FirebaseFirestore.instance //aca busco por el texto
        .collection('preguntas')
        .where('titulo', isGreaterThanOrEqualTo: query)
        .limit(100)
        .get();

    QuerySnapshot porPalabrasClave;
    for (var i = 0; i < palabras.length; i++) {
      porPalabrasClave = await FirebaseFirestore.instance
          .collection('preguntas')
          .where('palabrasClave', whereIn: palabras)
          .limit(100)
          .get();
    }

    //El tema es fijarseq ue no se repitan
    for (int i = 0; i < porTitulo.docs.length; i++) {
      preguntas.add(new Pregunta(
        titulo: porTitulo.docs[i].get('titulo'),
        descripcion: porTitulo.docs[i].get('descripcion'),
        id: porTitulo.docs[i].id,
        idAutor: porTitulo.docs[i].get('idAutor'),
        foto: porTitulo.docs[i].get('foto'),
        votos: porTitulo.docs[i].get('votos'),
        palabrasClave: porTitulo.docs[i].get('palabrasClave'),
      ));
    }

    //ESTO SE ASEGURA QUE AGREGAR VALORES DISTINTOS
    for (int i = 0; i < porPalabrasClave.docs.length; i++) {
      bool repetido = false;
      for (int j = 0; j < preguntas.length; j++) {
        if (preguntas[j].id == porPalabrasClave.docs[i].id) {
          repetido = true;
          break;
        }
      }
      if (!repetido) {
        preguntas.add(Pregunta(
          titulo: porPalabrasClave.docs[i].get('titulo'),
          descripcion: porPalabrasClave.docs[i].get('descripcion'),
          id: porPalabrasClave.docs[i].id,
          idAutor: porPalabrasClave.docs[i].get('idAutor'),
          foto: porPalabrasClave.docs[i].get('foto'),
          votos: porPalabrasClave.docs[i].get('votos'),
          palabrasClave: porPalabrasClave.docs[i].get('palabrasClave'),
        ));
      }
    }
    return preguntas;
  }

  Widget preguntaWidget(Pregunta pregunta) {
    //esto NO es cuando se selecciona uno
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
          color: Color(0xff002764),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: ListTile(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        title: Text(pregunta.titulo,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(
          pregunta.descripcion,
          style: TextStyle(color: Colors.grey[200]),
        ), //ACA PODRIA METER LAS PALABRAS CLAVES COMO CHIP INPUTS
        onTap: () => pushNewScreen(context,
            screen: PreguntaPage(
              pregunta: pregunta,
            ),
            withNavBar: true),
      ),
    );
  }
}
