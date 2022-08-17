

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_domino/src/provider/app_preferences_provider.dart';
import 'package:score_domino/src/provider/score_provider.dart';
import 'package:package_info/package_info.dart';
import 'package:score_domino/src/routes/routes.dart';
import 'package:get/get.dart';
import 'Translations.dart';
import 'src/controllers/AdmobController.dart';
import 'src/pages/splash_page.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final appVersion = 'v${packageInfo.version}';
  final preferences = AppPreferencesProvider(appVersion);
  await preferences.initPreferences();
  

  // final status = await AppTrackingTransparency.requestTrackingAuthorization();


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