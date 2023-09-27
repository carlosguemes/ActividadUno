import 'package:flutter/material.dart';

import 'App.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async{

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());


}




