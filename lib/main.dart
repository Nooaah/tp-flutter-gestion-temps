import 'package:flutter/material.dart';
import 'page_accueil_minuterie.dart';

const String CLE_TEMPS_TRAVAIL = 'Temps de travail';
const String CLE_PAUSE_COURTE = 'Pause courte';
const String CLE_PAUSE_LONGUE = 'Pause longue';

const TEMPS_TRAVAIL_DEFAUT = 30;
const TEMPS_PAUSE_COURTE_DEFAUT = 5;
const TEMPS_PAUSE_LONGUE_DEFAUT = 20;

void main() {
  runApp(MyApp());
}

const double REMPLISSAGE_DEFAUT = 5.0;

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
