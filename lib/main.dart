

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_domino/src/provider/app_preferences_provider.dart';
import 'package:score_domino/src/provider/score_provider.dart';
import 'package:score_domino/src/routes/routes.dart';



//TODO: ADD "SHARE TO SOCIAL MEDIA" 
class MyApp extends StatelessWidget {
  
  final AppPreferencesProvider preferences;

  const MyApp(this.preferences, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ScoreProvider>(create: (_) => ScoreProvider()),
         ChangeNotifierProvider<AppPreferencesProvider>(
          create: (_) => preferences),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:  false,
        initialRoute: '/',
        routes: getApplicationRoutes(),
      ),
    );
  }
}