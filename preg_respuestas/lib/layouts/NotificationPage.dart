import 'package:flutter/material.dart';
import 'package:preg_respuestas/widgets/NotificationTile.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Notificaciones",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: ((BuildContext context, int index) {
          return Dismissible(
            key: ValueKey(""),
            child: NotificationTile(
              titulo: "Tiene una nueva notification",
            ),
            onDismissed: (direction) {
              print("Eliminado");
              //TODO: ACA HAY QUE HACER UN REMOVE ITEM
            },
          );
        }),
      ),
    );
  }
}
