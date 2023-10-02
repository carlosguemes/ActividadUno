import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget{
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
        ),
      ),

      Padding(
        padding:EdgeInsets.symmetric(horizontal: 500, vertical: 5),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input Password',
          ),
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
          obscureText: true,
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: (){}, child: Text("Aceptar")),),

        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: (){}, child: Text("Cancelar")),)
      ],)

    ]);

    Scaffold scaffold = Scaffold(
      body: columna,
      backgroundColor: Colors.orangeAccent,
    );

    return scaffold;
    }

}