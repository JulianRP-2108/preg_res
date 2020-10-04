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
        backgroundColor: Colors.greenAccent,
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
          onSearch: getPreguntas,
          cancellationWidget: Icon(Icons.cancel, color: Colors.black),
          searchBarController: _searchBarController,
          onItemFound: (Pregunta pregunta, int index) {
            //esto NO es cuando se selecciona uno
            return Container(
              margin: EdgeInsets.only(top: 8.0),
              decoration: BoxDecoration(
                  color: Colors.greenAccent[200],
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: ListTile(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                title: Text(pregunta.titulo,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                subtitle: Text(
                    '$index'), //ACA PODRIA METER LAS PALABRAS CLAVES COMO CHIP INPUTS
                onTap: () => pushNewScreen(context,
                    screen: PreguntaPage(
                        //pregunta: pregunta,
                        ),
                    withNavBar: true),
              ),
            );
          },
        ),
      ),
    );
  }

  //ESTA SERIA LA FUNCION QUE VA LLAMANDO AL API CADA VEZ QUE SE CAMBIA EL QUERY
  Future<List<Pregunta>> getPreguntas(String query) async {
    await Future.delayed(Duration(seconds: query.length == 4 ? 10 : 1));
    List<Pregunta> preguntas = new List<Pregunta>();
    for (int i = 0; i < 20; i++) {
      preguntas.add(Pregunta(
          titulo: "¿Como se calcula el area de un circulo?",
          descripcion: "Descripcion"));
    }
    return preguntas;
  }
}
