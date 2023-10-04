import 'package:actividad_uno/KTPaddingText/PaddingClass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget{

  late BuildContext _context;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  SnackBar snackBar = SnackBar(
    content: Text('Las contraseñas han de ser iguales'),
  );

  void onClickAceptarRegistrar() async {
    if (passwordController.text == repasswordController.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
        Navigator.of(_context).popAndPushNamed('/homeview');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
    else{
      ScaffoldMessenger.of(_context).showSnackBar(snackBar);
    }
  }

  void onClickCancelarRegistrar(){
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    AppBar appBar = AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      title: const Text('Registro'),
    );

    Column columna = Column(children: [
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Text('Bienvenido a Kyty Register', style: TextStyle(fontSize: 25)),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),

        PaddingClass(controlador: usernameController, labelText: 'Escribe tu usuario', esContrasenya: false),

        PaddingClass(controlador: passwordController, labelText: 'Escribe tu contraseña', esContrasenya: true),

        PaddingClass(controlador: repasswordController, labelText: 'Repite tu contraseña', esContrasenya: true),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickAceptarRegistrar,
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text("Aceptar")),),

        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickCancelarRegistrar,
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text("Cancelar")),)
      ],)

    ]);

    Scaffold scaffold = Scaffold(
      body: columna,
      backgroundColor: Colors.orangeAccent,
      appBar: appBar
    );

    return scaffold;
    }

}