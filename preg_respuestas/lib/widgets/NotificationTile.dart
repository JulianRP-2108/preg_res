import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotificationTile extends StatelessWidget {
  String titulo;

  NotificationTile({@required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.black,
      ),
      key: ValueKey(""),
      child: ListTile(
        title: Text(this.titulo),
        leading: Icon(Icons.notifications_active, color: Colors.redAccent),
        trailing: IconButton(
          icon: Icon(
            Icons.arrow_right,
            color: Colors.blueAccent,
          ),
          //Ir hasta la pantalla de la pregunta
          onPressed: () {
            print("Yending");
          },
        ),
      ),
    );
  }
}
