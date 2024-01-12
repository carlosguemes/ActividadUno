import 'package:actividad_uno/KTPaddingText/BottomMenu.dart';
import 'package:actividad_uno/Singletone/GeolocAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../FirestoreObjects/FbPost.dart';
import '../KTPaddingText/DrawerClass.dart';
import '../KTPaddingText/GridBuilderCell.dart';
import '../KTPaddingText/PostCellView.dart';
import '../Singletone/Admin.dart';
import '../Singletone/DataHolder.dart';
import 'LoginView.dart';

class HomeView extends StatefulWidget {

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GeolocAdmin geolocAdmin = GeolocAdmin();
  late BuildContext _context;

  bool bIsList = false;

  void onClickVolver() {
    FirebaseAuth.instance.signOut();
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> post = [];

  @override
  void initState() {
    descargarPosts();
    super.initState();
    DataHolder().admin.getPilotosF1();
  }

  void onItemListaClicked(int index){
    DataHolder().selectedPost = post[index];
    DataHolder().saveSelectedPostInCache();
    Navigator.of(context).pushNamed('/postview');
  }

  void descargarPosts() async{
    CollectionReference<FbPost> reference = db
        .collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost post, _) => post.toFirestore());

    QuerySnapshot<FbPost> querySnap = await reference.get();
    for (int i = 0; i < querySnap.docs.length; i++){
      setState(() {
        post.add(querySnap.docs[i].data());
      });
    }
  }

  Widget? creadorDeItemLista(BuildContext context, int index){
    return PostCellView(sText: post[index].titulo,
        dFontSize: 20,
        mcColores: Colors.red,
        iPosicion: index,
        onItemListaClickedFunction: onItemListaClicked,
    );
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index){
    return Divider(color: Colors.purpleAccent);
  }

  Widget creadorCeldas(BuildContext context, int index){
    return GridBuilderCell(
        post: post,
        iPosicion: index,
        onItemListaClickedFunction: onItemListaClicked,
    );
  }

  Widget celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: post.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      );
    } else {
      return creadorCeldas(context, post.length);
    }
  }

  void onBottomMenuPressed(int indice) {
    setState(() {
      if (indice == 0){
        bIsList = true;
      }
      else if (indice == 1){
        bIsList = false;
      }
    });
  }

  Future<void> eventoDrawerClass(int indice) async {
    if (indice == 0){
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil (
        MaterialPageRoute (builder: (BuildContext context) => LoginView()),
        ModalRoute.withName('/loginview'),
      );
    }

    else if (indice == 1){
      
    }
  }

  Future <void> pedirTemperatura() async{
    try {
      Position currentPosition = await DataHolder().geolocAdmin.registrarCambiosLoc();

      double temperatura = await DataHolder().admin.pedirTemperaturasEn(currentPosition.latitude, currentPosition.longitude);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Información'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('La temperatura actual es de: $temperatura'),

              ],
            ),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error al obtener la temperatura'),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> getPilotoF1() async{
    try {
      String nombre = await DataHolder().admin.getPilotosF1();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Información'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Piloto: $nombre'),

              ],
            ),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error al obtener el piloto'),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> buscarPorTitulo() async{
    TextEditingController _searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Buscar Post por Título'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Ingrese el título a buscar',
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  String searchValue = _searchController.text.trim();
                  if (searchValue.isNotEmpty) {
                    Navigator.of(context).pop(); // Cerrar el diálogo de búsqueda

                    List<Map<String, dynamic>> searchResults =
                    await DataHolder().fbAdmin.searchPostsByTitle(searchValue);

                    if (searchResults.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Resultados de la Búsqueda'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (var result in searchResults)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Título: ${result['Titulo']}'),
                                    ],
                                  ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text('Aceptar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Resultados de la Búsqueda'),
                            content: Text('No se encontraron posts con el título proporcionado.'),
                            actions: [
                              TextButton(
                                child: Text('Aceptar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: Text('Buscar'),
              ),
            ],
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Actividad1"),
        actions: [
          PopupMenuButton(
            onSelected: (indice) {
              switch (indice) {
                case 'apiTiempo':
                  pedirTemperatura();
                  break;
                case 'apiPiloto':
                  getPilotoF1();
                  break;
                case 'buscaTitulo':
                  buscarPorTitulo();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'apiTiempo',
                child: ListTile(
                  leading: Icon(Icons.sunny_snowing),
                  title: Text('Temperatura'),
                ),
              ),
              PopupMenuItem(
                value: 'apiPiloto',
                child: ListTile(
                  leading: Icon(Icons.drive_eta),
                  title: Text('Piloto aleatorio F1'),
                ),
              ),
              PopupMenuItem(
                value: 'buscaTitulo',
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: Text('Buscar por título'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child:
        celdasOLista(bIsList),
      ),
      bottomNavigationBar: BottomMenu(events: onBottomMenuPressed),

      drawer: DrawerClass(onItemTap: eventoDrawerClass),
    );
  }
}