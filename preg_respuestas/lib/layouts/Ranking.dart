import 'package:flutter/material.dart';
import 'package:preg_respuestas/widgets/RankingTile.dart';

class RankgingPage extends StatefulWidget {
  @override
  _RankgingPageState createState() => _RankgingPageState();
}

class _RankgingPageState extends State<RankgingPage> {
  String categoria;

  //TODO: IMPLEMENTAR EL BUSCAR POR ANUAL Y POR MES
  //COLOCAR UN NUMERO? PARA LA POSICION

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.categoria = "Anual";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ranking",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: Column(
          children: [
            _categoria(context, categoria),
            Divider(
              color: Colors.black,
            ),
            _lista(context, categoria),
          ],
        ),
      ),
    );
  }

  _categoria(BuildContext context, String categoria) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            categoria,
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            value: categoria,
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.blueAccent),
            underline: Container(
              height: 2,
              color: Colors.blueAccent,
            ),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.lightBlue,
            ),
            onChanged: (String newValue) {
              setState(() {
                print(newValue);
                this.categoria = newValue;
              });
            },
            items: <String>['Anual', 'Mensual']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  _lista(BuildContext context, String categoria) {
    List<Widget> tiles = new List();

    for (int i = 0; i < 20; i++) {
      tiles.add(RankingTile(
          nombre: "Matias Ziliotto",
          profileImage:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          puntaje: "Ptos: 250"));
    }
    return Expanded(
      //child: RefreshIndicator(
      child: ListView(
        children: tiles,
      ),
      //),
    );
  }
}
