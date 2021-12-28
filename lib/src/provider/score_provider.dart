import 'package:flutter/material.dart';

class ScoreProvider with ChangeNotifier {
  List<int> teamScoreOne = [0];
  List<int> teamScoreTwo = [0];
  String _teamNameOne = "Casa";
  String _teamNameTwo = "Visita";
  bool existWinner = false;

  constructor() {
    teamScoreOne.add(0);
    teamScoreTwo.add(0);
    notifyListeners();
  }


  String get teamNameOne => _teamNameOne;
  
  set teamNameOne(String value){
    _teamNameOne = value;
    notifyListeners();
  }
  
  set teamNameTwo(String value){
    _teamNameTwo = value;
    notifyListeners();
  }

  String get teamNameTwo => _teamNameTwo;



  addScore(int value, bool isOneValue) {
    if (isOneValue) {
      teamScoreOne.add(value);
      teamScoreTwo.add(0);
    } else {
      teamScoreOne.add(0);
      teamScoreTwo.add(value);
    }

    notifyListeners();
  }

  reset() {
    teamScoreOne = [];
    teamScoreOne.add(0);
    teamScoreTwo = [];
    teamScoreTwo.add(0);
    existWinner = false;
    notifyListeners();
  }

  calcExistWinner(int limit) {
    final acumulado1 = teamScoreOne.reduce((value, element) => value + element);
    if (acumulado1 >= limit) {
      existWinner = true;
      return 'Ganador $teamNameOne';
    }

    final acumulado2 = teamScoreTwo.reduce((value, element) => value + element);

    if (acumulado2 >= limit) {
      existWinner = true;
      return 'Ganador $teamNameTwo';
    }

    return null;
  }
}
