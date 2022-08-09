import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:score_domino/main.dart';
import 'package:score_domino/src/provider/app_preferences_provider.dart';
import 'package:score_domino/src/resources/app_config.dart';

import 'src/controllers/AdmobController.dart';

void main() async {
  Logger log = Logger();

  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final appVersion = 'v${packageInfo.version}';
  final preferences = AppPreferencesProvider(appVersion);
  await preferences.initPreferences();
  Get.lazyPut(() => AdmobController());
  log.v("Testing on ios");
  // final configuratedApp = AppConfig(
  //   env: AppEnv.dev,
  //   child: MyApp(preferences),
  //   nameAppFirebase: 'score-domino-test',
  // );
  return runApp(MyApp(preferences));
}
