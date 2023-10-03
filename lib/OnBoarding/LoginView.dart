import 'package:actividad_uno/App.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../KTPaddingText/PaddingClass.dart';

class LoginView extends StatelessWidget {

  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  void onClickAceptar() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: tecUsername.text,
        password: tecPassword.text,
      );
      Navigator.of(_context).popAndPushNamed('/homeview');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void onClickRegistrar(){
    Navigator.of(_context).popAndPushNamed('/registerview');
  }

  @override
  Widget build(BuildContext context) {

    _context = context;

    AppBar appBar = AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      title: const Text('Login'),
    );

    Column columna = Column(children: [
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text("Bienvenido a Kyty Login", style: TextStyle(fontSize: 25)),
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),

      PaddingClass(controlador: tecUsername, labelText: 'Escribe tu usuario', esContrasenya: false),

      PaddingClass(controlador: tecPassword, labelText: 'Escribe tu contraseña', esContrasenya: true),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickAceptar,
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text("Aceptar")), ),

        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickRegistrar,
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text("Registro")),)
      ],)

    ]);

    Scaffold scaffold = Scaffold (
      appBar: appBar,
      body: columna,
      backgroundColor: Colors.blueGrey,
    );

    return scaffold;
  }
}