import 'package:flutter/material.dart';
import 'package:gestion_temps/widgets.dart';

import 'main.dart';

class PageAccueilMinuterie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ma gestion du temps'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints contraints) {
          final double largeurDisponible = contraints.maxWidth;
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(REMPLISSAGE_DEFAUT),
                  ),
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Color(0xff009688),
                      texte: 'Travail',
                      taille: 20.0,
                      action: () => BoutonGenerique.methodeVide(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(REMPLISSAGE_DEFAUT),
                  ),
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Color(0xff607D8B),
                      texte: 'Mini pause',
                      taille: 20.0,
                      action: () => BoutonGenerique.methodeVide(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(REMPLISSAGE_DEFAUT),
                  ),
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Color(0xff455A64),
                      texte: 'Maxi pause',
                      taille: 20.0,
                      action: () => BoutonGenerique.methodeVide(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(REMPLISSAGE_DEFAUT),
                  ),
                ],
              ),
              Expanded(child: Text('Bonjour')),
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
                      action: () => BoutonGenerique.methodeVide(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(REMPLISSAGE_DEFAUT),
                  ),
                  Expanded(
                    child: BoutonGenerique(
                      couleur: Color(0xff009688),
                      texte: 'Relancer',
                      taille: 20.0,
                      action: () => BoutonGenerique.methodeVide(),
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
