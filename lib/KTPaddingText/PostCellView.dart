import 'package:flutter/material.dart';

class PostCellView extends StatelessWidget{

  final String sText;
  final double dFontSize;
  final MaterialColor mcColores;

  const PostCellView({super.key,
    required this.sText,
    required this.dFontSize,
    required this.mcColores
  });

  @override
  Widget build(BuildContext context) {
    return Text(sText,
      style: TextStyle(
          color: mcColores,
          fontSize: dFontSize),
    );
  }

}