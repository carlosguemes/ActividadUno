import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FirestoreObjects/FbPost.dart';

class HomeView extends StatefulWidget {

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late BuildContext _context;

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}