

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_domino/src/provider/app_preferences_provider.dart';
import 'package:score_domino/src/provider/score_provider.dart';
import 'package:package_info/package_info.dart';
import 'package:score_domino/src/routes/routes.dart';
import 'package:get/get.dart';
import 'Translations.dart';
import 'firebase_options.dart';
import 'src/controllers/AdmobController.dart';
import 'src/pages/splash_page.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';



//TODO:
//agregar estas keywords: 
// Anote domino,
// Anotar domino
// Cantidad de partidas que lleva cada jugador
// Añadir funcion para indicar capicúa, también configurar el monto de la 
// Capicúa y marcarlo en la tabla de anotacion
// Añadir funcion para jugar de 3 personas
// Añadir que se guarden las manos o partidas
// Añadir quien sale al inicio de cada partida
// Añadir cuando se ganó en zapatera o lisa
// Añadir insights
//TODO: AGREGAR SI NO TIENE INTERNET, NO CARGAR EL ANUNCIO Y SEGUIR AL HOMESCREEN
// Agregar escaner de dominos que cuentalas fichas -> https://apps.apple.com/do/app/domino-scan/id1483065272




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final appVersion = 'v${packageInfo.version}';
  final preferences = AppPreferencesProvider(appVersion);
  await preferences.initPreferences();
  


  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {}
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // final status = await AppTrackingTransparency.requestTrackingAuthorization();
await AppTrackingTransparency.requestTrackingAuthorization();

Get.lazyPut(() => AdmobController());

  // final configuratedApp = AppConfig(
  //   env: AppEnv.dev,
  //   child: MyApp(preferences),
  //   nameAppFirebase: 'score-domino-prod',
  // );
  runApp(MyApp(preferences));
}

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
      child: GetMaterialApp(
        debugShowCheckedModeBanner:  false,
        // initialRoute: '/',
        // routes: getApplicationRoutes(),
         locale: Get.deviceLocale,
        translations: MyTransalations(),
        home: SplashPage(),
      ),
    );
  }
}