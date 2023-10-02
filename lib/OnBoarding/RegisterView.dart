import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget{

  late BuildContext _context;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  void onClickAceptarRegistrar() async {
    if (passwordController.text == repasswordController.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
        Navigator.of(_context).popAndPushNamed('/loginview');
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
    Column columna = Column(children: [
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Text('Bienvenido a Kyty Register', style: TextStyle(fontSize: 25)),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Padding(
         padding:EdgeInsets.symmetric(horizontal: 500, vertical: 5),
          child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input User',
          ),
            controller: usernameController,
        ),
      ),

      Padding(
        padding:EdgeInsets.symmetric(horizontal: 500, vertical: 5),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input Password',
          ),
          controller: passwordController,
          obscureText: true,
        ),
      ),

      Padding(
        padding:EdgeInsets.symmetric(horizontal: 500, vertical: 5),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Repite Password',
          ),
          controller: repasswordController,
          obscureText: true,
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickAceptarRegistrar, child: Text("Aceptar")),),

        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickCancelarRegistrar, child: Text("Cancelar")),)
      ],)

    ]);

    Scaffold scaffold = Scaffold(
      body: columna,
      backgroundColor: Colors.orangeAccent,
    );

    return scaffold;
    }

}