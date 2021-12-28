import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_domino/src/provider/score_provider.dart';

class ShowResult extends StatefulWidget {
  const ShowResult({Key? key}) : super(key: key);

  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreProvider>(builder: (context, scoreProvider, _) {
      int sumOne = 0;
      int sumTwo = 0;
      if (scoreProvider.teamScoreOne.isNotEmpty &&
          scoreProvider.teamScoreTwo.isNotEmpty) {
        sumOne = scoreProvider.teamScoreOne.reduce((sum, acc) => sum + acc);
        sumTwo = scoreProvider.teamScoreTwo.reduce((sum, acc) => sum + acc);
      }
      return _result(sumOne, sumTwo);
    });
  }

  Widget _result(int sumOne, int sumTwo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(sumOne.toString(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
        Text(sumTwo.toString(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
