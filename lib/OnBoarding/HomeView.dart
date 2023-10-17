import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FirestoreObjects/FbPost.dart';
import '../KTPaddingText/GridBuilderCell.dart';
import '../KTPaddingText/PostCellView.dart';

class HomeView extends StatefulWidget {

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
        mcColores: Colors.red);
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index){
    return Divider(color: Colors.purpleAccent);
  }

  Widget creadorCeldas(BuildContext context, int index){
    return GridBuilderCell(post: post);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kyty"),),
      body: Center(
        child:
        celdasOLista(bIsList),
      ),
    );
  }
}