import 'package:flutter/material.dart';

class RankingTile extends StatelessWidget {
  String nombre;
  String profileImage;
  String puntaje;

  RankingTile(
      {@required this.nombre,
      @required this.profileImage,
      @required this.puntaje});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        color: Colors.blueAccent,
      ),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(this.profileImage)),
        title: Text(
          this.nombre,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Text(
          this.puntaje,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
