import 'package:actividad_uno/App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {

  late BuildContext _context;

  void onClickAceptar(){

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
      Padding(
        padding:EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 16),
        child: Flexible (child: SizedBox(width: 400, child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input User',
          ),
        ),
        ),
        ),
      ),

      Padding(
        padding:EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 16),
        child: Flexible (child: SizedBox(width: 400, child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input Password',
          ),
        ),
        ),
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickAceptar,
              child: Text("Aceptar")), ),

        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickRegistrar,
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