import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:score_domino/src/provider/app_preferences_provider.dart';
import 'package:score_domino/src/provider/score_provider.dart';

class Teams extends StatefulWidget {
  const Teams({Key? key}) : super(key: key);

  @override
  _TeamsState createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  late ScoreProvider _scoreProvider;

  String _nameOne = "";
  String _nameTwo = "";

  @override
  Widget build(BuildContext context) {
    _scoreProvider = Provider.of<ScoreProvider>(context, listen: true);

    _nameOne = _scoreProvider.teamNameOne;
    _nameTwo = _scoreProvider.teamNameTwo;
    return IconButton(
        onPressed: () {
          Provider.of<AppPreferencesProvider>(context, listen: false)
              .openModal = true;
          showPreferences();
        },
        icon: const Icon(Icons.supervised_user_circle_rounded,
            color: Colors.white, size: 35.0));
  }

  void showPreferences() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: const Text("Equipos"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: <Widget>[
                  TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: _scoreProvider.teamNameOne,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Equipo 1",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (valor) => setState(() {
                            if (valor.isNotEmpty) {
                              _nameOne = valor;
                            }
                          })),
                  const SizedBox(height: 20.0),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: _scoreProvider.teamNameTwo,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Equipo 2",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (valor) => setState(() {
                            if (valor.isNotEmpty) {
                              _nameTwo = valor;
                            }
                          })),
                ],
                mainAxisSize: MainAxisSize.min,
              );
            }),
            actions: <Widget>[
              TextButton(
                  onPressed: () => {
                        Navigator.of(context).pop(),
                        Provider.of<AppPreferencesProvider>(context,
                                listen: false)
                            .openModal = false,
                      },
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () => {
                        if (_nameOne.isNotEmpty && _nameTwo.isNotEmpty)
                          {
                            _scoreProvider.teamNameOne = _nameOne,
                            _scoreProvider.teamNameTwo = _nameTwo,
                            Navigator.of(context).pop(),
                            Provider.of<AppPreferencesProvider>(context,
                                    listen: false)
                                .openModal = false,
                          }
                      },
                  child: const Text('Ok'))
            ],
          );
        });
  }
}
