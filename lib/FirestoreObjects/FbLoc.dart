import 'package:cloud_firestore/cloud_firestore.dart';

class FbLoc {

  final String nombre;
  final GeoPoint geoloc;

  FbLoc({
    required this.nombre,
    required this.geoloc
  });

  factory FbLoc.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbLoc(
        nombre: data?['Nombre'],
        geoloc:data?['Localizacion'] != null ? data!['Localizacion'] : GeoPoint(0, 0)
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "Nombre": nombre,
      if (geoloc != null) "Localizacion": geoloc,
    };
  }

}