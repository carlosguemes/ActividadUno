import 'package:actividad_uno/KTPaddingText/BottomMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../FirestoreObjects/FbPost.dart';
import '../KTPaddingText/DrawerClass.dart';
import '../KTPaddingText/GridBuilderCell.dart';
import '../KTPaddingText/PostCellView.dart';
import '../Singletone/DataHolder.dart';
import '../Singletone/GeolocAdmin.dart';
import 'LoginView.dart';

class HomeView2 extends StatefulWidget {

  @override
  State<HomeView2> createState() => _HomeViewState2();
}

class _HomeViewState2 extends State<HomeView2> {
  late BuildContext _context;
  GeolocAdmin geolocAdmin = GeolocAdmin();
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
    loadGeoLocator();
  }

  void loadGeoLocator() async {
    Position pos = await DataHolder().geolocAdmin.determinePosition();
    print("-----------> Coordenadas: " + pos.toString());
    DataHolder().geolocAdmin.registrarCambiosLoc();
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

  void eventoDrawerClass(int indice){
    if (indice == 0){
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil (
        MaterialPageRoute (builder: (BuildContext context) => LoginView()),
        ModalRoute.withName('/loginview'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kyty"),),
      body: Center(
        child:
        celdasOLista(bIsList),
      ),
      bottomNavigationBar: BottomMenu(events: onBottomMenuPressed),

      drawer: DrawerClass(onItemTap: eventoDrawerClass),
    );
  }
}