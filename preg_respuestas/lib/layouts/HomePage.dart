import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:preg_respuestas/layouts/PerfilPage.dart';
import 'package:preg_respuestas/layouts/Ranking.dart';
import 'package:preg_respuestas/layouts/SearchPage.dart';
import 'package:preg_respuestas/layouts/screenExample.dart';
import 'package:preg_respuestas/modelos/Usuario.dart';

import 'NotificationPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PersistentTabController _tabController;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _tabController = PersistentTabController(initialIndex: 1);
    _hideNavBar = false;
    _manejoUsuario().then((exito) {
      if (!exito) {
        print("Ocurrio un error en el manejo de usuarios");
        exit(-1);
        //TODO: MEJOR MOSTRAR UN ALERT Y LUEGO CERRAR
      } else {
        print("Salio todo bien, los datos del usuario son los siguientes:");
        print(Usuario.getApellido());
        print(Usuario.getEmail());
      }
    });
  }

  List<Widget> _buildScreens() {
    return [RankgingPage(), SearchPage(), NotificationPage(), PerfilPage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.assessment),
        activeContentColor: Colors.white,
        title: "Ranking",
        activeColor: Color(0xff002764),
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Preguntas"),
        activeContentColor: Colors.white,
        activeColor: Color(0xff002764),
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications_active),
        title: ("Notificaciones"),
        activeContentColor: Colors.white,
        activeColor: Color(0xff002764),
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Perfil"),
        activeContentColor: Colors.white,
        activeColor: Color(0xff002764),
        inactiveColor: Colors.grey,
      ),
    ];
  }

  //Aca puedo guardar al usuario en la base de datos
  Future<bool> _manejoUsuario() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get();
      if (doc.exists) {
        //cargar el singleton con los datos
        Usuario.fromDocument(doc);
      } else {
        //ALMACENARLO
        Usuario.almacenarUsuario();
      }
    } catch (e) {
      print(e);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      screens: _buildScreens(), //Lista de pantallas disponibles
      controller: _tabController,
      items: _navBarsItems(),
      confineInSafeArea: true,
      onItemSelected: (index) {
        //se activa siempre, aunque toques la misma que estas parado
        print("Seleccionaron, $index");
      },
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      hideNavigationBar: _hideNavBar,

      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style7,
    );
  }
}
