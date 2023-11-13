import 'package:actividad_uno/OnBoarding/GestionView.dart';
import 'package:actividad_uno/OnBoarding/HomeView.dart';
import 'package:actividad_uno/OnBoarding/RegisterView.dart';
import 'package:actividad_uno/Singletone/PlatformAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'OnBoarding/LoginView.dart';
import 'OnBoarding/PerfilView.dart';
import 'OnBoarding/PhoneLoginView.dart';
import 'OnBoarding/PostView.dart';
import 'Splash/SplashView.dart';
import 'main.dart';

class App extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (PlatformAdmin().isWebPlatform()) {
      return MaterialApp(
        routes: {
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView(),
          '/splashview': (context) => SplashView(),
          '/perfilview': (context) => PerfilView(),
          '/postview': (context) => PostView(),
          '/gestionview': (context) => GestionView()
        },
        initialRoute: '/gestionview',
      );
    }

      else{
        return MaterialApp(
            routes: {
            '/loginview': (context) => PhoneLoginView(),
            '/registerview': (context) => RegisterView(),
            '/homeview': (context) => HomeView(),
            '/splashview': (context) => SplashView(),
            '/perfilview': (context) => PerfilView(),
            '/postview': (context) => PostView()
            },
            initialRoute: '/homeview',
        );
      }
    }
  }