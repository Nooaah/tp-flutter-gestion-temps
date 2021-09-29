import 'package:flutter/material.dart';
import 'package:gestion_temps/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class PageParametres extends StatelessWidget {
  const PageParametres({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paramètres')),
      body: Parametres(),
    );
  }
}

class Parametres extends StatefulWidget {
  const Parametres({Key? key}) : super(key: key);

  @override
  _ParametresState createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  TextEditingController txtTempsTravail = TextEditingController();
  TextEditingController txtTempsPauseCourte = TextEditingController();
  TextEditingController txtTempsPauseLongue = TextEditingController();

  @override
  void initState() {
    txtTempsTravail = TextEditingController();
    txtTempsPauseCourte = TextEditingController();
    txtTempsPauseLongue = TextEditingController();
    lireParametres();
    super.initState();
  }

  lireParametres() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? tempsTravail = preferences.getInt(CLE_TEMPS_TRAVAIL);
    if (tempsTravail == null) {
      await preferences.setInt(CLE_TEMPS_TRAVAIL, int.parse('30'));
    }
    int? tempsPauseCourte = preferences.getInt(CLE_PAUSE_COURTE);
    if (tempsPauseCourte == null) {
      await preferences.setInt(CLE_PAUSE_COURTE, int.parse('5'));
    }
    int? tempsPauseLongue = preferences.getInt(CLE_PAUSE_LONGUE);
    if (tempsPauseLongue == null) {
      await preferences.setInt(CLE_PAUSE_LONGUE, int.parse('20'));
    }
    setState(() {
      txtTempsTravail.text = tempsTravail.toString();
      txtTempsPauseCourte.text = tempsPauseCourte.toString();
      txtTempsPauseLongue.text = tempsPauseLongue.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTexte = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return Container(
        child: GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        Text(
          'Temps de travail',
          style: styleTexte,
        ),
        Text(''),
        Text(''),
        BoutonParametre(
          couleur: Color(0xff212121),
          texte: '-',
          valeur: -1,
          parametre: CLE_TEMPS_TRAVAIL,
          action: majParametres,
        ),
        TextField(
          controller: txtTempsTravail,
          style: styleTexte,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        BoutonParametre(
          couleur: Color(0xff4caf50),
          texte: '+',
          valeur: 1,
          parametre: CLE_TEMPS_TRAVAIL,
          action: majParametres,
        ),
        Text(
          'Temps pour une pause courte',
          style: styleTexte,
        ),
        Text(''),
        Text(''),
        BoutonParametre(
          couleur: Color(0xff212121),
          texte: '-',
          valeur: -1,
          parametre: CLE_PAUSE_COURTE,
          action: majParametres,
        ),
        TextField(
          controller: txtTempsPauseCourte,
          style: styleTexte,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        BoutonParametre(
          couleur: Color(0xff4caf50),
          texte: '+',
          valeur: 1,
          parametre: CLE_PAUSE_COURTE,
          action: majParametres,
        ),
        Text(
          'Temps pour une pause longue',
          style: styleTexte,
        ),
        Text(''),
        Text(''),
        BoutonParametre(
          couleur: Color(0xff212121),
          texte: '-',
          valeur: -1,
          parametre: CLE_PAUSE_LONGUE,
          action: majParametres,
        ),
        TextField(
          controller: txtTempsPauseLongue,
          style: styleTexte,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        BoutonParametre(
          couleur: Color(0xff4caf50),
          texte: '+',
          valeur: 1,
          parametre: CLE_PAUSE_LONGUE,
          action: majParametres,
        ),
      ],
    ));
  }

  void majParametres(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    switch (key) {
      case CLE_TEMPS_TRAVAIL:
        {
          int tempsTravail =
              preferences.getInt(CLE_TEMPS_TRAVAIL) ?? TEMPS_TRAVAIL_DEFAUT;
          tempsTravail += value;
          if (tempsTravail >= 1 && tempsTravail <= 180) {
            preferences.setInt(CLE_TEMPS_TRAVAIL, tempsTravail);
            setState(() {
              txtTempsTravail.text = tempsTravail.toString();
            });
          }
        }
        break;
      case CLE_PAUSE_COURTE:
        {
          int tempsPauseCourte =
              preferences.getInt(CLE_PAUSE_COURTE) ?? TEMPS_PAUSE_COURTE_DEFAUT;
          tempsPauseCourte += value;
          setState(() {
            txtTempsPauseCourte.text = tempsPauseCourte.toString();
          });
          if (tempsPauseCourte >= 1 && tempsPauseCourte <= 120) {
            preferences.setInt(CLE_PAUSE_COURTE, tempsPauseCourte);
            setState(() {
              txtTempsPauseCourte.text = tempsPauseCourte.toString();
            });
          }
        }
        break;
      case CLE_PAUSE_LONGUE:
        {
          int tempsPauseLongue =
              preferences.getInt(CLE_PAUSE_LONGUE) ?? TEMPS_PAUSE_LONGUE_DEFAUT;
          tempsPauseLongue += value;
          if (tempsPauseLongue >= 1 && tempsPauseLongue <= 180) {
            preferences.setInt(CLE_PAUSE_LONGUE, tempsPauseLongue);
            setState(() {
              txtTempsPauseLongue.text = tempsPauseLongue.toString();
            });
          }
        }
        break;
    }
  }
}
