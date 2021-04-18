import 'package:flutter/material.dart';
import 'package:walletter/view/login/login.dart';
import 'package:walletter/view/tab_bar_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Walletter',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    ); // Gerenciador de Estados Automático
  }
}
