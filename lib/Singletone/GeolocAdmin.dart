import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class GeolocAdmin{
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<Position> registrarCambiosLoc() async {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
    try {
      Position position = await Geolocator.getCurrentPosition();
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
      return position;
    } catch (e) {
      print('Error al obtener la posición: $e');
      throw Exception('Error al obtener la posición');
    }
  }

  Future<void> agregarUbicacionEnFirebase(GeoPoint ubicacion) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('Ubicacion').doc(uid).set({
        'Nombre': uid,
        'Localizacion': ubicacion,
      });
    } catch (e) {
      print('Error al agregar la ubicación en Firebase: $e');
      throw Exception('Error al agregar la ubicación en Firebase');
    }
  }

  Future<List<String>> obtenerUsuariosEnRango() async {
    List<String> usersInRange = [];

    try {
      // Obtén la posición actual del usuario
      Position userPosition = await Geolocator.getCurrentPosition();

      // Realiza la consulta en Firestore
      double radius = 5.0; // Radio en kilómetros
      GeoPoint center = GeoPoint(userPosition.latitude, userPosition.longitude);

      // Realiza una consulta que obtenga documentos dentro de un cuadrado
      // (puedes ajustar esto según tus necesidades y considerar la esfericidad de la Tierra)
      double latOffset = radius / 110.574;
      double lonOffset = radius / (111.32 * cos(center.latitude * pi / 180));

      QuerySnapshot result = await FirebaseFirestore.instance.collection('Ubicacion')
          .where('Localizacion', isGreaterThan: GeoPoint(center.latitude - latOffset, center.longitude - lonOffset))
          .where('Localizacion', isLessThan: GeoPoint(center.latitude + latOffset, center.longitude + lonOffset))
          .get();

      // Itera sobre los documentos y agrega los idUser a la lista
      result.docs.forEach((doc) {
        usersInRange.add(doc['idUser']);
      });
    } catch (e) {
      print('Error al obtener usuarios en rango: $e');
    }

    return usersInRange;
  }
}