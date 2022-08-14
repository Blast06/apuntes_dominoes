import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:score_domino/src/provider/app_preferences_provider.dart';
import 'package:score_domino/src/provider/score_provider.dart';
import 'package:get/get.dart';


class InputScore extends StatefulWidget {
  const InputScore({Key? key}) : super(key: key);

  @override
  _InputScoreState createState() => _InputScoreState();
}

class _InputScoreState extends State<InputScore> {
  final TextEditingController _textController = TextEditingController();

  late ScoreProvider _scoreProvider;

  @override
  Widget build(BuildContext context) {
    _scoreProvider = Provider.of<ScoreProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(children: [
          Text(_scoreProvider.teamNameOne,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          ElevatedButton(
              onPressed: () {
                if (!Provider.of<ScoreProvider>(context, listen: false)
                    .existWinner) {
                  Provider.of<AppPreferencesProvider>(context, listen: false)
                      .openModal = true;
                  addScore(true);
                }
              },
              child: const Icon(Icons.add))
        ]),
        Column(children: [
          Text(_scoreProvider.teamNameTwo,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          ElevatedButton(
              onPressed: () {
                if (!Provider.of<ScoreProvider>(context, listen: false)
                    .existWinner) {
                  Provider.of<AppPreferencesProvider>(context, listen: false)
                      .openModal = true;
                  addScore(false);
                }
              },
              child: const Icon(Icons.add))
        ]),
      ],
    );
  }

  void addScore(bool isOneValue) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("add_points".tr),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: TextFormField(
              keyboardType: TextInputType.number,
              controller: _textController,
              autofocus: true,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (valor) => setState(() {}),
              onFieldSubmitted: (_) {
                _doSubmit(isOneValue);
              },
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _textController.clear();

                    Navigator.of(context).pop();
                    Provider.of<AppPreferencesProvider>(context, listen: false)
                        .openModal = false;
                  },
                  child: Text("cancel".tr)),
              TextButton(
                  onPressed: () {
                     _doSubmit(isOneValue);
                  },
                  child: const Text("Ok"))
            ],
          );
        });
  }

  void _doSubmit(bool isOneValue) {
    if (_textController.text.trim() != "") {
      final value = int.parse(_textController.text.trim());
      if (value > 0) {
        _scoreProvider.addScore(value, isOneValue);
      }
      _textController.clear();

      Navigator.of(context).pop();
      Provider.of<AppPreferencesProvider>(context, listen: false).openModal =
          false;
    }
  }
}
