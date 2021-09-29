import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

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

  void demarrerTravail() {
    _temps = tempsTravail;
    _tempsTotal = tempsTravail;
  }

  void arreterMinuteur() {
    _estActif = false;
  }

  void relancerMinuteur() {
    if (_temps.inMilliseconds > 0) {
      _estActif = true;
    }
  }

  void demarrerPause(bool estCourte) async {
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
