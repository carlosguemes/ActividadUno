import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

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
    ]);

    Scaffold scaffold = Scaffold (
      body: columna,
    );

    return scaffold;
  }
}