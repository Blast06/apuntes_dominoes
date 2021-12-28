import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_domino/src/provider/app_preferences_provider.dart';
import 'package:score_domino/src/provider/score_provider.dart';

class ListScore extends StatefulWidget {
  const ListScore({Key? key}) : super(key: key);
  @override
  _ListScoreState createState() => _ListScoreState();
}

class _ListScoreState extends State<ListScore> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreProvider>(builder: (context, scoreProvider, _) {
      if (scoreProvider.teamScoreOne.isNotEmpty) {
        final existWinner = Provider.of<ScoreProvider>(context, listen: false)
            .calcExistWinner(
                Provider.of<AppPreferencesProvider>(context, listen: false)
                    .limitScore);

        if (existWinner != null) {
          if (Provider.of<AppPreferencesProvider>(context, listen: false).sound){
            onPlayWinner();
          }
          return _winnerDialog(existWinner);
        }
        return _viewList(scoreProvider);
      } else {
        return Container();
      }
    });
  }

  Widget _winnerDialog(String text) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(top: 15.0),
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
      duration: const Duration(seconds: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.amber
      ),
      curve: Curves.fastOutSlowIn,
      width: 260.0,
      height: 250.0,
      child: Center(
        child: Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue)),
      ),
    );
  }

  Widget _viewList(ScoreProvider scoreProvider) {
    List<Widget> lineScore = [];

    for (int i = 0; i < scoreProvider.teamScoreOne.length; i++) {
      final line = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(scoreProvider.teamScoreOne[i].toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          Text(scoreProvider.teamScoreTwo[i].toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ],
      );
      lineScore.add(line);
    }

    final _screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: SizedBox(
        height: _screenSize.height * 0.45,
        child:
            ListView(padding: const EdgeInsets.all(10.0), children: lineScore),
      ),
    );
  }

  void onPlayWinner() async {
  AssetsAudioPlayer  assetsAudioPlayer = AssetsAudioPlayer();
  assetsAudioPlayer.open(
    Audio("assets/sound_winner.mp3")
  );
}
}
