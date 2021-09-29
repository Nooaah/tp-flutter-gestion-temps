import 'package:flutter/material.dart';
import 'page_accueil_minuterie.dart';

const String CLE_TEMPS_TRAVAIL = 'tempsTravail';
const String CLE_PAUSE_COURTE = 'tempsPauseCourte';
const String CLE_PAUSE_LONGUE = 'tempsPauseLongue';

const TEMPS_TRAVAIL_DEFAUT = 30;
const TEMPS_PAUSE_COURTE_DEFAUT = 5;
const TEMPS_PAUSE_LONGUE_DEFAUT = 20;

// 🐙🐙🐙
// You can find all the commits of the creation of the application on my github
// https://github.com/Nooaah/tp-flutter-gestion-temps

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
        primarySwatch: Colors.green,
      ),
      home: PageAccueilMinuterie(),
    );
  }
}
