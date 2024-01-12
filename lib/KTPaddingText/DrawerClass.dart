import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerClass extends StatelessWidget{

  Function (int indice)? onItemTap;
  DrawerClass({Key? key, required this.onItemTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
                style: TextStyle(color: Colors.white),
                'Header'
            ),
          ),
          ListTile(
            leading: Image.asset('resources/logo_kyty.png'),
            selectedColor: Colors.blue,
            selected: true,
            title: const Text('Cerrar sesión'),
            onTap: () {
              onItemTap!(0);
            },
          ),

          ListTile(
            leading: Icon(Icons.map),
            selectedColor: Colors.blue,
            selected: true,
            title: const Text('Mostrar nombre de usuarios en rango de 5km'),
            onTap: () {
              onItemTap!(1);
            },
          ),
        ],
      ),
    );
  }

}