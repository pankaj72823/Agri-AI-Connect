import 'package:agri_ai_connect/Screens/disease_detection.dart';
import 'package:agri_ai_connect/Screens/login.dart';
import 'package:agri_ai_connect/Screens/signup.dart';
import 'package:agri_ai_connect/Screens/splash_screen.dart';
import 'package:agri_ai_connect/Screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(){
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }

}

