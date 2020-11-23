import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
          color: Color(0xff004e92)),
      child: ListTile(
        leading: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "1",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              CircleAvatar(backgroundImage: NetworkImage(this.profileImage)),
            ],
          ),
        ),
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
