import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario {

  final String nombre;
  final int edad;
  final double altura;
  final String colorPelo;
  GeoPoint geoloc;

  FbUsuario({
    required this.nombre,
    required this.edad,
    required this.altura,
    required this.colorPelo,
    required this.geoloc
  });

  factory FbUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbUsuario(
        nombre: data?['Nombre'],
        edad: data?['Edad'] != null ? data!['Edad'] : 0,
        altura: data?['Altura'] != null ? data!['Altura'] : 0,
        colorPelo: data?['colorPelo'] != null ? data!['colorPelo'] : 'Rubio',
        geoloc:data?['Localizacion'] != null ? data!['geoloc'] : GeoPoint(0, 0)
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "Nombre": nombre,
      if (edad != null) "Edad": edad,
      if (altura != null) "Altura": altura,
      if (colorPelo != null) "colorPelo" : colorPelo,
      if (geoloc != null) "Localizacion": geoloc,
    };
  }

}