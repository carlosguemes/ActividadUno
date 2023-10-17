import 'package:cloud_firestore/cloud_firestore.dart';

class FbPost{

  final String titulo;
  final String cuerpo;

  FbPost({
    required this.titulo,
    required this.cuerpo,
  });

}