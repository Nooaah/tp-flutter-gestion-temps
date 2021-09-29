import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class ModeleMinuteur {
  String temps;
  double pourcentage;
  ModeleMinuteur(this.temps, this.pourcentage);
}

class Minuteur {
  double _rayon = 1;
  bool _estActif = true;
  Duration _temps = Duration();
  Duration _tempsTotal = Duration();
  Duration tempsTravail = Duration(minutes: 30);

  Duration tempsPauseCourte = Duration(minutes: 5);
  Duration tempsPauseLongue = Duration(minutes: 20);

  void demarrerTravail() async {
    await lireParametres();
    _rayon = 1;
    _temps = Duration(minutes: tempsTravail.inMinutes, seconds: 0);
    _tempsTotal = _temps;
  }

  void arreterMinuteur() {
    _estActif = false;
  }

  void relancerMinuteur() {
    if (_temps.inMilliseconds > 0) {
      _estActif = true;
    }
  }

  Future lireParametres() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    tempsTravail = preferences.getInt(CLE_PAUSE_LONGUE) == null ? Duration(minutes: 30) : Duration(minutes: int.parse((preferences.getInt(CLE_TEMPS_TRAVAIL).toString())));
    tempsPauseCourte =
        preferences.getInt(CLE_PAUSE_COURTE) == null ? Duration(minutes: 5) : Duration(minutes: int.parse((preferences.getInt(CLE_PAUSE_COURTE).toString())));
    tempsPauseLongue =
        preferences.getInt(CLE_PAUSE_LONGUE) == null ? Duration(minutes: 20) : Duration(minutes: int.parse((preferences.getInt(CLE_PAUSE_LONGUE).toString())));
  }

  void demarrerPause(bool estCourte) async {
    await lireParametres();
    _rayon = 1;
    _temps = Duration(
      minutes:
          (estCourte) ? tempsPauseCourte.inMinutes : tempsPauseLongue.inMinutes,
      seconds: 0,
    );
    _tempsTotal = _temps;
  }

  String retournerTemps(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSecondes = t.inSeconds - (t.inMinutes * 60);
    String secondes = (numSecondes < 10)
        ? '0' + numSecondes.toString()
        : numSecondes.toString();
    String tempsFormate = minutes + ':' + secondes;
    return tempsFormate;
  }

  Stream<ModeleMinuteur> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String temps;
      if (this._estActif) {
        _temps = _temps - Duration(seconds: 1);
        _rayon = _temps.inSeconds / _tempsTotal.inSeconds;
        if (_temps.inSeconds <= 0) {
          _estActif = false;
        }
      }
      temps = retournerTemps(_temps);
      return ModeleMinuteur(temps, _rayon);
    });
  }
}
