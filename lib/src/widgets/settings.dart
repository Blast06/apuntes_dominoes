import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:score_domino/src/provider/app_preferences_provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late AppPreferencesProvider _appPreferencesProvider;

  int _limitScore = 100;
  bool _sound = false;

  @override
  Widget build(BuildContext context) {
    _appPreferencesProvider =
        Provider.of<AppPreferencesProvider>(context, listen: true);

    _limitScore = _appPreferencesProvider.limitScore;
    _sound = _appPreferencesProvider.sound;
    return IconButton(
        onPressed: () {
          _appPreferencesProvider.openModal = true;
          showPreferences();
        },
        icon: const Icon(
          Icons.settings,
          color: Colors.white,
          size: 35.0,
        ));
  }

  void showPreferences() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: const Text("Ajustes"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: <Widget>[
                  SwitchListTile(
                      title: const Text('Sonido'),
                      value: _sound,
                      onChanged: (valor) => {
                            setState(() {
                              _sound = valor;
                            })
                          }),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: _limitScore.toString(),
                      autofocus: false,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        labelText: "Limite de Puntos",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (valor) => setState(() {
                            if (valor != "") {
                              _limitScore = int.parse(valor);
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
                        _appPreferencesProvider.openModal = false,
                      },
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () => {
                        if (_limitScore > 0 && _limitScore <= 100)
                          {
                            _appPreferencesProvider.sound = _sound,
                            _appPreferencesProvider.limitScore = _limitScore,
                            Navigator.of(context).pop(),
                            _appPreferencesProvider.openModal = false,
                          }
                      },
                  child: const Text('Ok'))
            ],
          );
        });
  }
}
