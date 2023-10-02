import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'OnBoarding/LoginView.dart';
import 'main.dart';

class App extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/loginview':(context) => LoginView(),
      },
      initialRoute: '/loginview',
    );
  }
}