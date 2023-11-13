import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../KTPaddingText/PaddingClass.dart';

class PhoneLoginView extends StatefulWidget{
  @override
  State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {
  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecVerify = TextEditingController();
  String sVerificationCode ="";
  bool blMostrarVerificacion = false;

  void enviarTelefonoPressed() async{
    String sTelefono = tecPhone.text;

    await FirebaseAuth.instance.verifyPhoneNumber(
      verificationCompleted: verificacionCompletada,
      verificationFailed: verificacionFallida,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void enviarVerifyPressed() async{
    String smsCode = tecVerify.text;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: sVerificationCode, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void verificacionCompletada(PhoneAuthCredential credencial) async{
    await FirebaseAuth.instance.signInWithCredential(credencial);
    Navigator.of(context).popAndPushNamed('/homeview');
  }

  void verificacionFallida(FirebaseAuthException credencial){
    if (credencial.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }

  void codeSent(String codigo, int? iNumero) async{
    sVerificationCode = codigo;
    setState(() {
      blMostrarVerificacion = true;
    });
  }

  void codeAutoRetrievalTimeout(String sCadena){

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
          children: [
            PaddingClass(controlador: tecPhone, esContrasenya: false, labelText: "Número de teléfono"),
            TextButton(onPressed: enviarTelefonoPressed, child: Text("Enviar Teléfono")),
            if (blMostrarVerificacion)
              PaddingClass(controlador: tecVerify, esContrasenya: false, labelText: "Número Verificación"),
            if (blMostrarVerificacion)
              TextButton(onPressed: enviarVerifyPressed, child: Text("Enviar Verificación")),
          ],
        )
    );
  }
}