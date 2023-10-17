import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../FirestoreObjects/FbUsuario.dart';

class PerfilView extends StatelessWidget{

  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecEdad = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  void onClickAceptar(){

    FbUsuario usuario = FbUsuario(nombre: tecUsername.text,
        edad: int.parse(tecEdad.text), altura: 0, colorPelo: "Rubio");

    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;

    db.collection("Usuarios").doc(uidUsuario).set(usuario.toFirestore());

    Navigator.of(_context).popAndPushNamed('/homeview');
  }

  void onClickCancelar(){

  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        shadowColor: Colors.blue,
        backgroundColor: Colors.black26,
      ),

      body: Column(children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Text("Personaliza tu perfil", style: TextStyle(fontSize: 25)),
        Padding(
          padding:EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 16),
          child: Flexible (child: SizedBox(width: 400, child: TextField(
            controller: tecUsername,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              //hintText: 'Nombre',
              labelText: 'Nombre',
            ),
          ),
          ),
          ),
        ),

        Padding(
          padding:EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 0),
          child: Flexible(
              child: SizedBox(width: 400,
                child: TextFormField(
                  controller: tecEdad,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    //hintText: 'Input Password',
                    labelText: 'Edad',
                    fillColor: Colors.greenAccent,
                    filled: true,
                  ),
                ),
              )
          ),
        ),

        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: TextButton(onPressed: onClickAceptar,
                child: Text("Aceptar")),),

          Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: TextButton(onPressed: onClickCancelar,
                child: Text("Cancelar")),)
        ],)

      ],),

    );


  }

}