import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_domino/src/provider/app_preferences_provider.dart';
import 'package:score_domino/src/provider/score_provider.dart';
import 'package:score_domino/src/widgets/input_score.dart';
import 'package:score_domino/src/widgets/list_score.dart';
import 'package:score_domino/src/widgets/settings.dart';
import 'package:score_domino/src/widgets/show_result.dart';
import 'package:score_domino/src/widgets/teams.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/background.jpeg'),
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Column(children: [
            Container(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Settings(),
                    Teams(),
                  ]),
            ),
            Container(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: const Text("Anota Domino!!!",
                    style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            const InputScore(),
            const Divider(
                color: Colors.yellow,
                thickness: 2,
                indent: 20.0,
                endIndent: 20.0),
            Visibility(
                visible:
                    !Provider.of<AppPreferencesProvider>(context, listen: true)
                        .openModal,
                child: const ListScore()),
            const Spacer(flex: 1),
            const Divider(
                color: Colors.red, thickness: 2, indent: 20.0, endIndent: 20.0),
            const ShowResult(),
            const Spacer(),
          ])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh_outlined),
        backgroundColor: Colors.red,
        onPressed: () {
          Provider.of<ScoreProvider>(context, listen: false).reset();
        },
      ),
    );
  }
}
