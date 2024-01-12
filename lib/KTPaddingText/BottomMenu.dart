import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {
  Function (int indice)? events;

  BottomMenu({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => events!(0), child: Icon(Icons.list,color: Colors.pink,)),
          TextButton(onPressed: () => events!(1), child: Icon(Icons.grid_view,color: Colors.pink,)),
          TextButton(onPressed: () => events!(2), child: Icon(Icons.map,color: Colors.pink,))
        ]
    );
  }

  void boton1Pressed(){
    botonesClick(0);
  }

  void boton2Pressed(){
    botonesClick(1);
  }

  void boton3Pressed(){
    botonesClick(2);
  }

  void botonesClick(int indice){
    print(indice.toString());
  }
}