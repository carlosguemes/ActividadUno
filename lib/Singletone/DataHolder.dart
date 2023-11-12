import 'package:shared_preferences/shared_preferences.dart';

import '../FirestoreObjects/FbPost.dart';

class DataHolder{
  FbPost? selectedPost;

  static final DataHolder _dataHolder = new DataHolder._internal();

  factory DataHolder(){
    return _dataHolder;
  }

  DataHolder._internal(){
    initCachedFbPost();
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
    selectedPost=FbPost(titulo: titulo, cuerpo: cuerpo);

    return selectedPost;
  }



}