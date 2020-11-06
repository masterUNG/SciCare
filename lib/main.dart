import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scicare/screens/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  String nameUser;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'SCICARE application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff003c71),
        primarySwatch: 
        Colors.blue/*Color(0xff003C71)*/,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: SplashScreen(),
    );
  }
}

