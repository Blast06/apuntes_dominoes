import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:score_domino/src/pages/home_page.dart';
import 'AdmobController.dart';

class SplashController extends GetxController {
  final admob = Get.find<AdmobController>();
  Logger log = Logger();
  
  

  bool showInterstitial = false;

  @override
  void onReady() async {
    log.i("onReady of splash controller");
  

    super.onReady();
    // await admob.loadAd();

    await Future.delayed(Duration(seconds: 5), () {
      admob.showAdIfAvailable();
      Get.off(() => const HomePage(), transition: Transition.zoom);
    });
  }

  void onInit() async {
    super.onInit();
    log.i("Init of splash controller");
    // await prepareApi();
    // await admob.loadInterstitial();
  }
}
