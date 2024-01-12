import 'package:actividad_uno/OnBoarding/GestionView.dart';
import 'package:actividad_uno/OnBoarding/HomeView.dart';
import 'package:actividad_uno/OnBoarding/MapaView.dart';
import 'package:actividad_uno/OnBoarding/RegisterView.dart';
import 'package:actividad_uno/Singletone/PlatformAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'OnBoarding/HomeView2.dart';
import 'OnBoarding/LoginView.dart';
import 'OnBoarding/PerfilView.dart';
import 'OnBoarding/PhoneLoginView.dart';
import 'OnBoarding/PostView.dart';
import 'Splash/SplashView.dart';

class App extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (PlatformAdmin().isWebPlatform()) {
      return MaterialApp(debugShowCheckedModeBanner: false, theme:ThemeData(
        textTheme: GoogleFonts.offsideTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
        routes: {
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView(),
          '/splashview': (context) => SplashView(),
          '/perfilview': (context) => PerfilView(),
          '/postview': (context) => PostView(),
          '/gestionview': (context) => GestionView(),
          '/mapaview': (context) => MapaView()
        },
        initialRoute: '/loginview',
      );
    }

      else{
        return MaterialApp(debugShowCheckedModeBanner: false,
          theme:ThemeData(
            textTheme: GoogleFonts.ubuntuCondensedTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
            routes: {
            '/loginview': (context) => PhoneLoginView(),
            '/registerview': (context) => RegisterView(),
            '/homeview': (context) => HomeView(),
            '/splashview': (context) => SplashView(),
            '/perfilview': (context) => PerfilView(),
            '/postview': (context) => PostView(),
              '/mapaview': (context) => MapaView()
            },
            initialRoute: '/loginview',
        );
      }
    }
  }