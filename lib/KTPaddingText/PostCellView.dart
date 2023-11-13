import 'package:flutter/material.dart';

class PostCellView extends StatelessWidget{

  final String sText;
  final double dFontSize;
  final MaterialColor mcColores;
  final int iPosicion;
  final Function (int indice)? onItemListaClickedFunction;

  const PostCellView({super.key,
    required this.sText,
    required this.dFontSize,
    required this.mcColores,
    required this.iPosicion,
    required this.onItemListaClickedFunction
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          color: mcColores,
          child: Row(
            children: [
              Image.asset("resources/logo_kyty.png", width: 70,
                  height: 70),
              Text(sText, style: TextStyle(fontSize: dFontSize)),
              TextButton(onPressed: null,
                  child: Text("+", style: TextStyle(fontSize: dFontSize)))
            ],
          )
      ),
      onTap: () {
        onItemListaClickedFunction!(iPosicion);
      },
    );
  }

}