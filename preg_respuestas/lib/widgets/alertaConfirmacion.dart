import 'package:flutter/material.dart';

class ALertaConfirmacion extends StatelessWidget {
  String pregunta;
  String titulo;

  ALertaConfirmacion({@required this.pregunta, @required this.titulo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Align(
        child: Text(this.titulo),
        alignment: Alignment.center,
      ),
      titlePadding: EdgeInsets.symmetric(vertical: 10.0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notification_important,
            color: Colors.redAccent,
          ),
          Text(
            this.pregunta,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () {
              print("Aceptar");
            },
            child: Text("Aceptar")),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              print("Cancelar");
            },
            child: Text("Cancelar")),
      ],
    );
  }
}
