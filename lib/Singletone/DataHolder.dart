import 'package:actividad_uno/FirestoreObjects/FbLoc.dart';
import 'package:actividad_uno/Singletone/FirebaseAdmin.dart';
import 'package:actividad_uno/Singletone/GeolocAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirestoreObjects/FbPost.dart';
import 'Admin.dart';

class DataHolder{
  String sNombre = "Kyty";
  FbPost? selectedPost;
  GeolocAdmin geolocAdmin = GeolocAdmin();
  Admin admin = Admin();
  FirebaseAdmin fbAdmin = FirebaseAdmin();
  FbLoc? fbLoc;

  static final DataHolder _dataHolder = new DataHolder._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;

  factory DataHolder(){
    return _dataHolder;
  }

  DataHolder._internal(){
    initCachedFbPost();
  }

  void crearPostEnFB(FbPost post){
    CollectionReference<FbPost> reference = db
        .collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost post, _) => post.toFirestore());

    reference.add(post);
  }

  void saveSelectedPostInCache() async{
    if (selectedPost!=null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('titulo', selectedPost!.titulo);
      prefs.setString('cuerpo', selectedPost!.cuerpo);
    }
  }

  Future<FbPost?> initCachedFbPost() async{
    if (selectedPost!=null) return selectedPost;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? titulo = prefs.getString('titulo');
    titulo??="";

    String? cuerpo = prefs.getString('cuerpo');
    cuerpo??="";

    String? imagen = prefs.getString('imagen');
    imagen??="";

    print("SHARED PREFERENCES ---> "+ titulo);
    selectedPost=FbPost(titulo: titulo, cuerpo: cuerpo, imagen: imagen);

    return selectedPost;
  }

  Future<FbLoc?> loadFbUsuario() async{
    String uid=FirebaseAuth.instance.currentUser!.uid;
    print("UID DE DESCARGA loadFbLoc------------->>>> ${uid}");
    DocumentReference<FbLoc> ref=db.collection("Ubicacion")
        .doc(uid)
        .withConverter(fromFirestore: FbLoc.fromFirestore,
      toFirestore: (FbLoc usuario, _) => usuario.toFirestore(),);


    DocumentSnapshot<FbLoc> docSnap=await ref.get();
    print("docSnap DE DESCARGA loadFbLoc------------->>>> ${docSnap.data()}");
    fbLoc=docSnap.data();
    return fbLoc;
  }



}