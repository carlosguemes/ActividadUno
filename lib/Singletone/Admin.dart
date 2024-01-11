import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'PilotoF1.dart';

class Admin {
  Admin();

  Future<double> pedirTemperaturasEn(double lat, double lon) async {
    var url = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': lat.toString(),
      'longitude': lon.toString(),
      'hourly': 'temperature_2m',
    });

    print("URL RESULTANTE: " + url.toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      print("MAPA ENTERO: " + jsonResponse.toString());

      var jsonHourly = jsonResponse['hourly'];
      var jsonTimes = jsonHourly['time'];
      var jsonTiempoActual = jsonTimes[0];
      var jsonTemperaturas = jsonHourly['temperature_2m'];
      var jsonTemperaturaActual = jsonTemperaturas[0];

      double temperaturaActual = jsonTemperaturaActual.toDouble();

      return temperaturaActual;
    } else {
      print('Request failed with status: ${response.statusCode}.');

      // Si hay un error, puedes lanzar una excepción o retornar un valor por defecto
      throw Exception('Error al obtener la temperatura');
    }
  }

  void getPilotosF1() async{
    int iAnio=2023;
    final response = await http
        .get(Uri.parse('http://ergast.com/api/f1/${iAnio}/drivers.json'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      print("Pilotos F1: "+jsonDecode(response.body).toString());
      Map<String, dynamic> json=jsonDecode(response.body);
      //print("DEBUG: --->>>>>>>>>   "+json["MRData"].toString());
      Map<String, dynamic> json2=json["MRData"];
      //print("DEBUG: --->>>>>>>>>   "+json2["DriverTable"].toString());
      Map<String, dynamic> json3=json2["DriverTable"];
      //print("DEBUG: --->>>>>>>>>   "+json3["Drivers"].toStri ng());
      List<dynamic> listaPilotos=json3["Drivers"];

      List<dynamic> listaPilotos2=json["MRData"]["DriverTable"]["Drivers"];

      List<PilotoF1> listaPilotosFinal=[];

      for(int i=0;i<listaPilotos2.length;i++){
        listaPilotosFinal.add(PilotoF1.fromJson(listaPilotos2[i]));
      }

      print("DEBUG: NOMBRE DEL PILOTO EN LA POSICION 10: "+listaPilotosFinal[10].givenName+"   "+listaPilotosFinal[10].familyName);

      //print("DEBUG: --->>>>>>>>>   "+json["MRData"]["DriverTable"]["Drivers"].toString());

      //return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}