import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GestionView extends StatefulWidget {

  @override
  State<GestionView> createState() => _GestionViewState();
}

class _GestionViewState extends State<GestionView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSession();
  }

  void checkSession() async{
    await Future.delayed(Duration(seconds: 4));
    Navigator.of(context).popAndPushNamed("/splashview");
  }

  @override
  Widget build(BuildContext context) {

    AppBar appBar = AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      title: const Text('Gestión'),
    );

    Column columna = Column(children: [
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Bienvenido a Gestión de Kyty", style: TextStyle(fontSize: 25, fontFamily: 'Agbalumo'),),
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