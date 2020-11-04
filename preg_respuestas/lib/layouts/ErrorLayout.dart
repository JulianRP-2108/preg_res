import 'dart:io';

import 'package:flutter/material.dart';

class ErrorLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.black,
          child: Center(
              child: AlertDialog(
            contentPadding: EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Align(
              child: Text("Error al iniciar"),
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
                  "Se produjo un error, se ha avisado al administrador, por favor, intente más tarde",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    //TODO: aca tengo que avisar y cerrar la app
                    exit(0);
                  },
                  child: Text("Aceptar")),
            ],
          )),
        ),
      ),
    );
  }
}
