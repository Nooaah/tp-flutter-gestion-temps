import 'package:flutter/material.dart';
import 'package:gestion_temps/minuteur.dart';
import 'package:gestion_temps/page_parametres.dart';
import 'package:gestion_temps/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'main.dart';

class PageAccueilMinuterie extends StatelessWidget {
  Minuteur minuteur = Minuteur();

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> elementsMenu = [];

    minuteur.demarrerTravail();

    elementsMenu.add(PopupMenuItem(
      value: 'Paramètres',
      child: Text('Paramètres'),
    ));

    void allerParametres(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageParametres(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ma gestion du temps'),
        actions: <Widget>[
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return elementsMenu.toList();
          }, onSelected: (s) {
            if (s == 'Paramètres') allerParametres(context);
          }),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints contraints) {
          final double largeurDisponible = contraints.maxWidth;
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top:70,left:REMPLISSAGE_DEFAUT,right: REMPLISSAGE_DEFAUT),
                  ),
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Color(0xff357a38),
                      texte: 'Travail',
                      taille: 20.0,
                      action: () => minuteur.demarrerTravail(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(REMPLISSAGE_DEFAUT),
                  ),
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Color(0xff4caf50),
                      texte: 'Mini pause',
                      taille: 20.0,
                      action: () => minuteur.demarrerPause(true),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(REMPLISSAGE_DEFAUT),
                  ),
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Color(0xff6fbf73),
                      texte: 'Maxi pause',
                      taille: 20.0,
                      action: () => minuteur.demarrerPause(false),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(REMPLISSAGE_DEFAUT),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  initialData: ModeleMinuteur('00:00', 1),
                  stream: minuteur.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    ModeleMinuteur minuteur = snapshot.data;
                    return Container(
                      child: CircularPercentIndicator(
                        radius: largeurDisponible / 2,
                        lineWidth: 10.0,
                        // ignore: unnecessary_null_comparison
                        percent: (minuteur.pourcentage == null)
                            ? 1
                            : minuteur.pourcentage,
                        center: Text(
                          // ignore: unnecessary_null_comparison
                          (minuteur.temps == null) ? '00:00' : minuteur.temps,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        backgroundColor: Color(0xff357a38),
                        progressColor: Color(0xff4caf50),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(REMPLISSAGE_DEFAUT),
                  ),
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Color(0xff212121),
                      texte: 'Arrêter',
                      taille: 20.0,
                      action: () => minuteur.arreterMinuteur(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(REMPLISSAGE_DEFAUT),
                  ),
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Color(0xff357a38),
                      texte: 'Relancer',
                      taille: 20.0,
                      action: () => minuteur.relancerMinuteur(),
                    ),
                  ),
                  Padding(
                    // Modification du padding bottom, car les boutons dépassaient de l'écran sur le simulateur iOS IPhone 12
                    padding: EdgeInsets.only(
                        top: REMPLISSAGE_DEFAUT,
                        right: REMPLISSAGE_DEFAUT,
                        bottom: REMPLISSAGE_DEFAUT + 100,
                        left: REMPLISSAGE_DEFAUT),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
