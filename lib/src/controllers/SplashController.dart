import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:score_domino/src/pages/home_page.dart';
import 'AdmobController.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:is_first_run/is_first_run.dart';

class SplashController extends GetxController {
  final admob = Get.find<AdmobController>();
  Logger log = Logger();

  bool showInterstitial = false;

  @override
  void onReady() async {
    log.i("onReady of splash controller");
    bool firstRun = await IsFirstRun.isFirstRun();
    if (firstRun) {
      final status =
          await AppTrackingTransparency.requestTrackingAuthorization();
    }
    super.onReady();
    // await admob.loadAd();

    await Future.delayed(const Duration(seconds: 5), () {
      // admob.showAdIfAvailable();
      if (!firstRun) {
        admob.appOpenAd!.show();
      }
      Get.off(() => const HomePage(), transition: Transition.zoom);
    });
  }

  @override
  void onInit() async {
    super.onInit();
    log.i("Init of splash controller");
    // await prepareApi();
    // await admob.loadInterstitial();
  }
}
