import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:preg_respuestas/layouts/PreguntaPage.dart';

// ignore: must_be_immutable
class NotificationTile extends StatelessWidget {
  String titulo;

  NotificationTile({@required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.white10,
      ),
      key: ValueKey(""),
      child: Card(
        color: Colors.blue[100],
        child: ListTile(
          onTap: () {
            pushNewScreen(context, screen: PreguntaPage(), withNavBar: false);
          },
          title: Text(this.titulo),
          leading: Icon(Icons.notifications_active, color: Colors.redAccent),
          trailing: Icon(
            Icons.arrow_right,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
