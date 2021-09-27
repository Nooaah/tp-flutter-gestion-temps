import 'package:flutter/material.dart';
import 'page_accueil_minuterie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion du temps',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: PageAccueilMinuterie(),
    );
  }
}
