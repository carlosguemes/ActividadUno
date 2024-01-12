import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../FirestoreObjects/FbUsuario.dart';


class FirebaseAdmin {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FbUsuario? usuario;

  void actualizarPerfilUsuario(FbUsuario usuario) async {
    //Crear documento con ID NUESTRO (o proporsionado por nosotros)
    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
    await db.collection("Usuarios").doc(uidUsuario).set(usuario.toFirestore());
  }

  Future<FbUsuario?> loadFbUsuario() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference<FbUsuario> ref = db.collection("Usuarios")
        .doc(uid)
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
      toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),);


    DocumentSnapshot<FbUsuario> docSnap = await ref.get();
    usuario = docSnap.data();
    return usuario;
  }

  Future<List<Map<String, dynamic>>> searchPostsByTitle(String searchValue) async {
    QuerySnapshot querySnapshot = await db
        .collection('Posts')
        .where('Titulo', isGreaterThanOrEqualTo: searchValue)
        .get();

    return querySnapshot.docs
        .where((doc) =>
    (doc['Titulo'] as String).contains(searchValue))
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

}